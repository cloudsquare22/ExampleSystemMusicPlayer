//
//  Music.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2020/12/12.
//

import SwiftUI
import MediaPlayer

final class Music: ObservableObject {
    var player: MPMusicPlayerController? = nil
    let propertyKeys = [
        MPMediaItemPropertyAlbumArtist,
        MPMediaItemPropertyAlbumArtistPersistentID,
        MPMediaItemPropertyAlbumPersistentID,
        MPMediaItemPropertyAlbumTitle,
        MPMediaItemPropertyArtist,
        MPMediaItemPropertyArtistPersistentID,
        MPMediaItemPropertyComposer,
        MPMediaItemPropertyComposerPersistentID,
    ]
    @Published var propertyValues: [(String, String)] = []
    @Published var mediaItem: MPMediaItem? = nil

    init() {
        self.player = MPMusicPlayerController.systemMusicPlayer
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(Music.changeMusic(_:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        self.mediaItem = self.player!.nowPlayingItem
    }

    @objc func changeMusic(_ notification:Notification?) {
        print(#function)
        self.propertyValues = []
        self.mediaItem = self.player!.nowPlayingItem
        for propertyKey in propertyKeys {
            var value = ""
            if let v = self.mediaItem?.value(forProperty: propertyKey) as? String {
                value = v
            }
            self.propertyValues.append((propertyKey, value))
        }
        print(self.propertyValues)
    }

}
