//
//  Manager.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/6/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var session: URLSession
    var decoder: JSONDecoder
    var cache: NetworkCache
    
    private init(
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder(),
        cache: NetworkCache = NetworkCache.shared
    ){
        self.session = session
        self.decoder = decoder
        self.cache = cache
    }
}

extension NetworkManager {
    
    func fetchDecodable<T>(model: T.Type, originalUrl: String, completion: @escaping (T?) -> Void) where T : Decodable{
        if let data = self.cache.get(url: originalUrl) as? T{
            completion(data)
            return
        }
        
        guard let url = URL(string: originalUrl) else {
            completion(nil)
            return
        }
        self.session.dataTask(with: url){ (data, res, err) in
            if let err = err {
                print(err)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
               return
            }

            
            do {
                let decoded = try self.decoder.decode(model, from: data)
                self.cache.set(data: data, url: originalUrl)
                completion(decoded)
            } catch {
                print(error)
                completion(nil)
            }

        }.resume()
    }

    
    func fetchRaw(originalUrl: String, completion: @escaping (Data?) -> Void) {
        if let data = self.cache.get(url: originalUrl){
            completion(data)
            return
        }
        
        guard let url = URL(string: originalUrl) else {
            completion(nil)
            return
        }
        self.session.dataTask(with: url){ (data, res, err) in
            if let err = err {
                print(err)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
               return
            }

            self.cache.set(data: data, url: originalUrl)
            completion(data)
        }.resume()
    }

}
