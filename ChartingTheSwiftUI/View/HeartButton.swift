//
//  HeartButton.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/8/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import SwiftUI

struct HeartButton: View {
    
    @State var isLoved: Bool
    var setLoved: ()->()

    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .opacity(isLoved ? 1 : 0)
                .scaleEffect(isLoved ? 1.0 : 0.1)
                .animation(.linear)
            Image(systemName: "heart")
        }.font(.system(size: 40))
            .onTapGesture {
                self.isLoved.toggle()
                self.setLoved()
        }
        .foregroundColor(isLoved ? .red : .black)
    }
}
