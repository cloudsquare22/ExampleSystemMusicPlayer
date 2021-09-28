//
//  SongListView.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2021/03/16.
//

import SwiftUI

struct SongListView: View {
    @EnvironmentObject var music: Music
    @State var searchText: String = ""

    var body: some View {
        NavigationView {
            List {
                Section() {
                    TextField("Search Text", text: self.$searchText)
                }
                NavigationLink("Now Playing", destination: MediaItemView(item: self.music.player?.nowPlayingItem))
                ForEach(0..<self.music.songs.count,  id: \.self) { index in
                    NavigationLink(destination: MediaItemView(item: self.music.songs[index])) {
                        VStack {
                            HStack {
                                Text(self.music.songs[index].title!)
                                Spacer()
                                Text("\(self.music.songs[index].playCount)")
                            }
                            HStack {
                                Text(self.music.songs[index].artist!)
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .onSubmit(of: .text) {
                self.music.setSongs(search: self.searchText)
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
