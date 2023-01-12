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
        Table(self.music.idMPMediaItemList) {
            TableColumn("Title") { item in
                Text(item.item.title!)
            }
            TableColumn("Last") { item in
                if let lastdate = item.item.lastPlayedDate {
                    HStack {
                        Text(lastdate, style: .date)
                        Text(lastdate, style: .time)
                    }
                }
                else {
                    Text("-")
                }
            }
            TableColumn("Count") { item in
                Text("\(item.item.playCount)")
            }
        }
        .onAppear() {
            print("SongListView." + #function)
            self.music.setSongs()
        }
        .refreshable {
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
