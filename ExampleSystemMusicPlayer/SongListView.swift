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
    @State var serchtext: String = ""

    @State private var sortOrder: [KeyPathComparator<IdMPMediaItem>] = []

    var body: some View {
        NavigationStack {
            Table(self.music.idMPMediaItemList, sortOrder: self.$sortOrder) {
                TableColumn("Title", value: \.item.title!)
                TableColumn("Album", value: \.item.albumTitle!)
                TableColumn("Artist", value: \.item.artist!)
                TableColumn("Count", value: \.item.playCount.description)
                    .width(100)
                TableColumn("Last") { item in
                    if let lastdate = item.item.lastPlayedDate {
                        Text(lastdate, style: .date)
                    }
                    else {
                        Text("-")
                    }
                }
                .width(150)
            }
            .foregroundStyle(.primary)
            .onChange(of: sortOrder) { old, new in
                self.music.idMPMediaItemList.sort(using: new)
            }
            .onAppear() {
                print("SongListView." + #function)
            }
            .refreshable {
                self.music.setSongs()
            }
        }
        .searchable(text: self.$searchText)
        .onChange(of: self.serchtext) { old, new in
            
        }
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
            .environmentObject(Music())
    }
}
