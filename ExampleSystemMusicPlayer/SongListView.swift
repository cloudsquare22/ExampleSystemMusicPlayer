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

    @State private var sortOrder = [KeyPathComparator(\SongInformation.title), KeyPathComparator(\SongInformation.albumTitle), KeyPathComparator(\SongInformation.artist)]

    var body: some View {
        Table(self.music.songInfoamrtionList, sortOrder: $sortOrder) {
            TableColumn("Title", value: \.title)
            TableColumn("Album", value: \.albumTitle)
            TableColumn("Artist", value: \.artist)
//            TableColumn("Last") { item in
//                if let lastdate = item.lastPlayedDate {
//                    HStack {
//                        Text(lastdate, style: .date)
//                        Text(lastdate, style: .time)
//                    }
//                }
//                else {
//                    Text("-")
//                }
//            }
            TableColumn("Count") { item in
                Text("\(item.playCount)")
            }
        }
        .onAppear() {
            print("SongListView." + #function)
            self.music.setSongs()
        }
        .refreshable {
            self.music.setSongs()
        }
        .onChange(of: sortOrder) {
            print("onchanged sort")
            self.music.songInfoamrtionList.sort(using: $0)
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
