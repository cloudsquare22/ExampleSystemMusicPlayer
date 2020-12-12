//
//  ContentView.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2020/12/12.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    @EnvironmentObject var music: Music

    var body: some View {
        TabView(selection: $selection) {
            MediaItemView()
                .tabItem {
                    Image(systemName: "music.note")
                        .font(.title)
                    Text("MediaItem")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Music())
    }
}
