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
        }
        .onAppear(perform: {
             self.albumVM.fetchArt(self.index, true){
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
