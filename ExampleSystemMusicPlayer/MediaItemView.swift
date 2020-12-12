//
//  MediaItemView.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2020/12/12.
//

import SwiftUI

struct MediaItemView: View {
    @EnvironmentObject var music: Music

    var body: some View {
        List {
            ForEach(0..<self.music.propertyValues.count) { index in
                VStack {
                    Text(self.music.propertyValues[index].0)
                    Text(self.music.propertyValues[index].1)
                }
            }
        }
    }
}

struct MediaItemView_Previews: PreviewProvider {
    static var previews: some View {
        MediaItemView()
            .environmentObject(Music())
    }
}
