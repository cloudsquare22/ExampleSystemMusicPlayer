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
    @State var selection: Int = 0
    @State var selectionSort: Int = 0

    var body: some View {
        NavigationView {
            List {
                Section() {
                    TextField("Search Text", text: self.$searchText)
                    Picker(selection: self.$selection, content: {
                        Text("Title").tag(0)
                        Text("Album Title").tag(1)
                        Text("Artist").tag(2)
                    }, label: {})
                        .pickerStyle(SegmentedPickerStyle())
                        .labelsHidden()
                        .onChange(of: self.selection, perform: {newValue in
                            self.music.setSongs(search: self.searchText,
                                                selection: self.selection,
                                                selectionSort: self.selectionSort)
                        })
                    Picker(selection: self.$selectionSort, content: {
                        Text("Title").tag(0)
                        Text("Playcount").tag(1)
                    }, label: {})
                        .pickerStyle(SegmentedPickerStyle())
                        .labelsHidden()
                        .onChange(of: self.selectionSort, perform: {newValue in
                            self.music.setSongs(search: self.searchText,
                                                selection: self.selection,
                                                selectionSort: self.selectionSort)
                        })
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
                self.music.setSongs(search: self.searchText,
                                    selection: self.selection,
                                    selectionSort: self.selectionSort)
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
