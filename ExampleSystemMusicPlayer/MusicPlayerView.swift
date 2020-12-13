//
//  MusicPlayerView.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2020/12/13.
//

import SwiftUI

struct MusicPlayerView: View {
    @EnvironmentObject var music: Music

    var body: some View {
        List {
            ForEach(0..<self.music.playerModesStates.count) { index in
                VStack(alignment: .leading) {
                    Text(self.music.playerModesStates[index].0)
                    Text(self.music.playerModesStates[index].1)
                }
            }
        }
    }
}

struct MusicPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerView()
            .environmentObject(Music())
    }
}
