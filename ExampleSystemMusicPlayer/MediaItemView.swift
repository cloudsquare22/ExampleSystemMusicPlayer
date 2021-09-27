//
//  MediaItemView.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2020/12/12.
//

import SwiftUI
import MediaPlayer

struct MediaItemView: View {
    @EnvironmentObject var music: Music
    var item: MPMediaItem? = nil

    var body: some View {
        List {
            Button(action: {
                self.music.onePlay(item: self.item!)
            }, label: {
                Text("Play song")
            })
            ForEach(0..<self.music.propertyValues.count) { index in
                VStack(alignment: .leading) {
                    Text(self.music.propertyValues[index].0)
                    if self.music.propertyValues[index].0 != MPMediaItemPropertyArtwork {
                        Text(self.music.propertyValues[index].1)
                    }
                    else {
                        if let artwork = self.music.artWork {
                            Image(uiImage: artwork)
                            .resizable()
                            .scaledToFit()
                        }
                    }
                }
            }
        }
        .navigationTitle(self.item!.title!)
        .onAppear() {
            print("*** lalala ***")
            self.music.setPropertyValues(item: self.item)
        }
    }
}

struct MediaItemView_Previews: PreviewProvider {
    static var previews: some View {
        MediaItemView()
            .environmentObject(Music())
    }
}
