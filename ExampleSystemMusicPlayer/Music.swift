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
        (MPMediaItemPropertyAlbumArtist, String.self),
        (MPMediaItemPropertyAlbumArtistPersistentID, String.self),
        (MPMediaItemPropertyAlbumPersistentID, String.self),
        (MPMediaItemPropertyAlbumTitle, String.self),
        (MPMediaItemPropertyArtist, String.self),
        (MPMediaItemPropertyArtistPersistentID, String.self),
        (MPMediaItemPropertyComposer, String.self),
        (MPMediaItemPropertyComposerPersistentID, String.self),
        (MPMediaItemPropertyGenre, String.self),
        (MPMediaItemPropertyGenrePersistentID, String.self),
        (MPMediaItemPropertyHasProtectedAsset, String.self),
        (MPMediaItemPropertyIsCompilation, String.self),
        (MPMediaItemPropertyIsCloudItem, String.self),
        (MPMediaItemPropertyMediaType, String.self),
        (MPMediaItemPropertyPersistentID, String.self),
        (MPMediaItemPropertyPlayCount, String.self),
        (MPMediaItemPropertyPodcastPersistentID, String.self),
        (MPMediaItemPropertyPodcastTitle, String.self),
        (MPMediaItemPropertyTitle, String.self),
    ]
    @Published var propertyValues: [(String, String)] = []
    @Published var mediaItem: MPMediaItem? = nil

    init() {
        self.player = MPMusicPlayerController.systemMusicPlayer
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(Music.changeMusic(_:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        self.mediaItem = self.player!.nowPlayingItem
        setPropertyValues()
    }

    @objc func changeMusic(_ notification:Notification?) {
        print(#function)
        setPropertyValues()
    }
    
    func setPropertyValues() {
        self.propertyValues = []
        self.mediaItem = self.player!.nowPlayingItem
        for propertyKey in propertyKeys {
            print(propertyKey.1)

            
//            if let v = self.mediaItem?.value(forProperty: propertyKey) as? String {
//                value = v
//            }
//            self.propertyValues.append((propertyKey, value))
        }
        print(self.propertyValues)
    }

}
