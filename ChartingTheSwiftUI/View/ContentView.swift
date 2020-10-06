//
//  ContentView.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/5/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var albumVM = AlbumViewModel()
    @Environment(\.horizontalSizeClass) var hSizeClass: UserInterfaceSizeClass?

    var body: some View {
        let columns: Int = hSizeClass == .compact ? 2 : 3
        let rows: Int = albumVM.albumsObj.count / columns
        
        return NavigationView {
            if self.albumVM.albumsObj.count == 0 {
                HStack {
                    Spacer()
                    Text("loading...")
                    Spacer()
                }
                    .navigationBarTitle("Charting The SwiftUI", displayMode: .inline)
                    .navigationBarHidden(true)
            } else {
                GridStack(rows: rows, columns: columns){ row, col in
                    AlbumCell(
                        index: (row*col) + row,
                        albumVM: self.albumVM
                    )
                }
                    .navigationBarTitle("Charting The SwiftUI", displayMode: .inline)
            }
        }
            .onAppear(perform: self.albumVM.fetchAlbums)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
