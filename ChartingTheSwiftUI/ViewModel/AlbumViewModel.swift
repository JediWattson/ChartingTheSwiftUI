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
    func fetchArt(_ index: Int){
        let album = self.albumsObj[index]
        self.service.fetchRaw(originalUrl: album.artworkUrl100){
            result in
            guard let data = result else {return}
            DispatchQueue.main.async {
                self.albumsObj[index].image = UIImage(data: data)
            }            
        }
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
