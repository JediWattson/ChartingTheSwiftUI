//
//  AlbumCell.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/6/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct AlbumCell: View {
    var index: Int
    var albumVM: AlbumViewModel
    
    @State private var img: UIImage?
    
    var body: some View {
        let album = albumVM.albumsObj[index]
        return NavigationLink(
            destination: Detail(
                index: self.index,
                albumVM: self.albumVM
            )
        ) {
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    Text(album.artistName)
                        .font(.system(size: 13))
                    Image(uiImage: getImage())
                        .resizable()
                        .scaledToFit()
                    Text(album.name)
                        .font(.system(size: 15))
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    Spacer()
                    HStack{
                        Spacer()
                        ZStack{
                            Image(systemName: "heart.fill")
                                .opacity(album.isLoved ? 1 : 0)
                                .scaleEffect(album.isLoved ? 1.0 : 0.1)
                                .animation(.linear)
                            Image(systemName: "heart")
                        }
                            .foregroundColor(album.isLoved ? .red : .black)

                    }
                }
                Spacer()
            }
        }
            .buttonStyle(PlainButtonStyle())
            .onAppear(perform: {
                self.albumVM.fetchArt(self.index){
                    result in
                    DispatchQueue.main.async {
                        self.img = result
                    }
                }
            })
    }
    
    func getImage() -> UIImage {
        guard let img = UIImage(named: "loading-art") else {
            fatalError("NO IMAGE")
        }

        return self.img ?? img
    }
    
}
