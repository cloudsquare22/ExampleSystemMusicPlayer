//
//  SongListView.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2021/03/16.
//

import SwiftUI

struct SongListView: View {
    @EnvironmentObject var music: Music

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Now Playing", destination: MediaItemView(item: self.music.player?.nowPlayingItem))
                ForEach(0..<self.music.songs.count,  id: \.self) { index in
                    NavigationLink(self.music.songs[index].title!, destination: MediaItemView(item: self.music.songs[index]))
                }
            }
            .navigationTitle(Text("\(self.music.songs.count) songs"))
//            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear() {
            print("SongListView." + #function)
            self.music.setSongs()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
            .environmentObject(Music())
    }
}
