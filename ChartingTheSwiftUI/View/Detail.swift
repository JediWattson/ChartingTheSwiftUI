//
//  Detail.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/6/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct Detail: View {
    var index: Int
    var albumVM: AlbumViewModel
                
    @State private var img: UIImage?
    @State private var releaseDate: String = ""
    @State private var genres: String = ""
    
    var body: some View {
        let album = albumVM.albumsObj[index]
        return VStack{
            Image(uiImage: getImage())
                .resizable()
                .scaledToFit()
                .padding(8)
            
            HStack{
                Text(album.name)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 8)
                    .padding(.bottom, 8)
                    .font(.system(size: 23))
                Spacer()
            }
            
            HStack{
                Text(album.artistName)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 8)
                Spacer()
            }

            Spacer()

            HStack{
                Text(self.releaseDate)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 8)
                    .padding(.bottom, 8)
                Spacer()
            }

            HStack{
                Text(self.genres)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 8)
                Spacer()
            }

            
            Spacer()
            
            HStack{
                Spacer()
                HeartButton(isLoved: album.isLoved){
                    self.albumVM.setLoved(index: self.index)
                }
                    .padding(.trailing, 8)
                    .padding(.bottom, 8)
            }
        
        }
        .onAppear(perform: {
            self.fetchArt()
            self.setDate(releaseDate: album.releaseDate)
            self.setGenres(genres: album.genres)
        })
    }
    
}


extension Detail {
    
    func setGenres(genres: [Genres]){
        self.genres = genres
            .filter{ $0.name != "Music" }
            .reduce(""){ acc, genre in
                acc.count > 0
                    ? "\(acc), \(genre.name)"
                    : "Genres: \(genre.name)"
            }
    }
    
    func getImage() -> UIImage {
        guard let img = UIImage(named: "loading-art") else {
            fatalError("NO IMAGE")
        }
        return self.img ?? img
    }
    
    func fetchArt(){
        self.albumVM.fetchArt(self.index, true){
            result in
            DispatchQueue.main.async {
                self.img = result
            }
        }
    }
    
    func setDate(releaseDate: String){
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
            
        if let date = dateFormatterGet.date(from: releaseDate) {
            DispatchQueue.main.async {
                self.releaseDate = "Released: \(dateFormatterPrint.string(from: date))"
            }
        } else {
          print("There was an error decoding the string")
        }
    }
}
