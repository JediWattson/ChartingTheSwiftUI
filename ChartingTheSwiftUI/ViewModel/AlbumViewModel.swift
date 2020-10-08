//
//  AlbumViewModel.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/6/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import UIKit

class AlbumViewModel: ObservableObject {
    let albumsUrl: String = "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/100/explicit.json"

    var service: NetworkManager = NetworkManager.shared
    
    @Published private(set) var albumsObj = [AlbumObj]()
    func fetchArt(_ index: Int, _ isDetail: Bool = false, completion: @escaping (UIImage) -> ()){
        let album = self.albumsObj[index]
        var url = album.artworkUrl100
        if isDetail {
            url = url.replacingOccurrences(of: "200x200", with: "1000x1000")
        }
            
        self.service.fetchRaw(originalUrl: url){
            result in
            guard
                let data = result,
                let img = UIImage(data: data)
            else {return}
            completion(img)
        }
    }
    
    func setLoved(index: Int){
        self.albumsObj[index].isLoved.toggle()
        print(self.albumsObj[index].isLoved)
    }
    
    func fetchAlbums(){
        self.service.fetchDecodable(model: Query.self, originalUrl: albumsUrl){[weak self]
            results in
            guard let self = self, let albums = results?.feed.results else {return}
//            var rank: Int32 = 0
//            albums.forEach{
//                item in
//                self.manager.insertAlbum(albumObj: item, rank: rank)
//                rank = rank + 1
//            }
            DispatchQueue.main.async {
                self.albumsObj.append(contentsOf: albums)
            }
        }
    }
}
