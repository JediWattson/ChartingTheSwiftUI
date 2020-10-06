//
//  AlbumCell.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/6/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct AlbumCell: View {
    var album: AlbumObj
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Spacer()
                Text(self.album.artistName)
                    .font(.system(size: 13))
                Image(uiImage: getImage())
                    .resizable()
                    .scaledToFit()
                Text(self.album.name)
                    .font(.system(size: 15))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Spacer()
            }
            Spacer()
        }
    }
    
    func getImage() -> UIImage {
        guard let img = UIImage(named: "loading-art") else {
            fatalError("NO IMAGE")
        }
        return album.image ?? img
    }
    
}
