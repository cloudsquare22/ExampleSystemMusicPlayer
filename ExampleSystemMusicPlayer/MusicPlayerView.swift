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
            Section(header: Text("Property")) {
                ForEach(0..<self.music.playerModesStates.count) { index in
                    VStack(alignment: .leading) {
                        Text(self.music.playerModesStates[index].0)
                        Text(self.music.playerModesStates[index].1)
                    }
                }
            }
            Section(header: Text("Control")) {
                Button(action: {
                    self.music.player?.skipToNextItem()
                    self.music.player?.play()
                },
                label: {
                    Text("skipToNextItem()")
                })
                Button(action: {
                    self.music.player?.skipToBeginning()
                },
                label: {
                    Text("skipToBeginning()")
                })
                Button(action: {
                    self.music.player?.skipToPreviousItem()
                },
                label: {
                    Text("skipToPreviousItem()")
                })
                Button(action: {
                    self.music.player?.play()
                },
                label: {
                    Text("play()")
                })
                Button(action: {
                    self.music.player?.pause()
                },
                label: {
                    Text("pause()")
                })
                Button(action: {
                    self.music.player?.stop()
                },
                label: {
                    Text("stop()")
                })
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
