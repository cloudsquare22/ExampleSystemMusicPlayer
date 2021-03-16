//
//  ContentView.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2020/12/12.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
    @EnvironmentObject var music: Music

    var body: some View {
        TabView(selection: $selection) {
            MusicPlayerView()
                .tabItem {
                    Image(systemName: "ipod")
                        .font(.title)
                    Text("MusicPlayer")
                }
                .tag(0)
//            MediaItemView()
//                .tabItem {
//                    Image(systemName: "music.note.list")
//                        .font(.title)
//                    Text("MediaItem")
//                }
//                .tag(1)
            SongListView()
                .tabItem {
                    Image(systemName: "music.note.list")
                        .font(.title)
                    Text("MediaItem")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Music())
    }
}
