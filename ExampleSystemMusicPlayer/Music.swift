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
    let propertyKeys: [(name: String, type: Any.Type)] = [
        (MPMediaItemPropertyAlbumArtist, String.self),
        (MPMediaItemPropertyAlbumArtistPersistentID, MPMediaEntityPersistentID.self),
        (MPMediaItemPropertyAlbumPersistentID, MPMediaEntityPersistentID.self),
        (MPMediaItemPropertyAlbumTitle, String.self),
        (MPMediaItemPropertyAlbumTrackCount, Int.self),
        (MPMediaItemPropertyAlbumTrackNumber, Int.self),
        (MPMediaItemPropertyArtist, String.self),
        (MPMediaItemPropertyArtistPersistentID, MPMediaEntityPersistentID.self),
        (MPMediaItemPropertyArtwork, MPMediaItemArtwork.self),
        (MPMediaItemPropertyAssetURL, URL.self),
        (MPMediaItemPropertyBeatsPerMinute, Int.self),
        (MPMediaItemPropertyBookmarkTime, TimeInterval.self),
        (MPMediaItemPropertyIsCloudItem, Bool.self),
        (MPMediaItemPropertyComments, String.self),
        (MPMediaItemPropertyIsCompilation, Bool.self),
        (MPMediaItemPropertyComposer, String.self),
        (MPMediaItemPropertyComposerPersistentID, MPMediaEntityPersistentID.self),
        (MPMediaItemPropertyDateAdded, Date.self),
        (MPMediaItemPropertyDiscCount, Int.self),
        (MPMediaItemPropertyDiscNumber, Int.self),
        (MPMediaItemPropertyIsExplicit, Bool.self),
        (MPMediaItemPropertyGenre, String.self),
        (MPMediaItemPropertyGenrePersistentID, MPMediaEntityPersistentID.self),
        (MPMediaItemPropertyLastPlayedDate, Date.self),
        (MPMediaItemPropertyLyrics, String.self),
        (MPMediaItemPropertyMediaType, MPMediaType.self),
        (MPMediaItemPropertyPersistentID, MPMediaEntityPersistentID.self),
        (MPMediaItemPropertyPlayCount, Int.self),
        (MPMediaItemPropertyPlaybackDuration, TimeInterval.self),
        (MPMediaItemPropertyPlaybackStoreID, String.self),
        (MPMediaItemPropertyPodcastPersistentID, MPMediaEntityPersistentID.self),
        (MPMediaItemPropertyPodcastTitle, String.self),
        (MPMediaItemPropertyHasProtectedAsset, Bool.self),
        (MPMediaItemPropertyRating, Int.self),
        (MPMediaItemPropertyReleaseDate, Date.self),
        (MPMediaItemPropertySkipCount, Int.self),
        (MPMediaItemPropertyTitle, String.self),
        (MPMediaItemPropertyUserGrouping, String.self),
    ]
    @Published var propertyValues: [(String, String)] = []
    @Published var mediaItem: MPMediaItem? = nil
    @Published var artWork: UIImage? = nil
    @Published var playerModesStates: [(String, String)] = []
    @Published var songs: [MPMediaItem] = []
    @Published var songInfoamrtionList: [SongInformation] = []
    @Published var idMPMediaItemList: [IdMPMediaItem] = []

    let playbackStateString = ["stopped", "playing", "paused", "interrupted", "seekingForward", "seekingBackward"]
    let repeatModeString = ["default", "none", "one", "all"]
    let shuffleModeString = ["default", "off", "songs", "albums"]

    init() {
        self.player = MPMusicPlayerController.systemMusicPlayer
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(Music.changeMusic(_:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        self.mediaItem = self.player!.nowPlayingItem
        setPropertyValues()
        setPlayerModesStates()
    }

    @objc func changeMusic(_ notification:Notification?) {
        print(#function)
        setPropertyValues()
        setPlayerModesStates()
    }
    
    func setPlayerModesStates() {
        self.playerModesStates = []
        self.playerModesStates.append(("nowPlayingItem", "Go to MediaItem Tab."))
        self.playerModesStates.append(("indexOfNowPlayingItem", "\(self.player!.indexOfNowPlayingItem)"))
        self.playerModesStates.append(("playbackState", self.playbackStateString[self.player!.playbackState.rawValue]))
        self.playerModesStates.append(("repeatMode", self.repeatModeString[self.player!.repeatMode.rawValue]))
        self.playerModesStates.append(("shuffleMode", self.shuffleModeString[self.player!.shuffleMode.rawValue]))
    }
    
    func setPropertyValues(item: MPMediaItem? = nil) {
        self.propertyValues = []
        if item == nil {
            self.mediaItem = self.player!.nowPlayingItem
        }
        else {
            self.mediaItem = item
        }
        for propertyKey in propertyKeys {
            print("\(propertyKey.name):\(propertyKey.type)")
            
            var valueString = ""
            if propertyKey.type == String.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? String {
                    valueString = value
                }
            }
            else if propertyKey.type == MPMediaEntityPersistentID.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? MPMediaEntityPersistentID {
                    valueString = String(value)
                }
            }
            else if propertyKey.type == Int.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? Int {
                    valueString = String(value)
                }
            }
            else if propertyKey.type == TimeInterval.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? TimeInterval {
                    valueString = String(value)
                }
            }
            else if propertyKey.type == Bool.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? Bool {
                    valueString = String(value)
                }
            }
            else if propertyKey.type == URL.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? URL {
                    valueString = value.absoluteString
                }
            }
            else if propertyKey.type == MPMediaItemArtwork.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? MPMediaItemArtwork {
                    self.artWork = value.image(at: CGSize(width: value.bounds.width, height: value.bounds.height))
                }
            }
            else if propertyKey.type == Date.self {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .medium
                dateFormatter.locale = .current
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? Date {
                    valueString = dateFormatter.string(from: value)
                }
            }
            else if propertyKey.type == MPMediaType.self {
                if let value = self.mediaItem?.value(forProperty: propertyKey.name) as? UInt {
                    switch value {
                    case MPMediaType.music.rawValue:
                        valueString = "music"
                    case MPMediaType.podcast.rawValue:
                        valueString = "podcast"
                    case MPMediaType.audioBook.rawValue:
                        valueString = "audioBook"
                    case MPMediaType.audioITunesU.rawValue:
                        valueString = "audioITunesU"
                    case MPMediaType.anyAudio.rawValue:
                        valueString = "anyAudio"
                    case MPMediaType.movie.rawValue:
                        valueString = "movie"
                    case MPMediaType.tvShow.rawValue:
                        valueString = "tvShow"
                    case MPMediaType.videoPodcast.rawValue:
                        valueString = "videoPodcast"
                    case MPMediaType.musicVideo.rawValue:
                        valueString = "musicVideo"
                    case MPMediaType.videoITunesU.rawValue:
                        valueString = "videoITunesU"
                    case MPMediaType.homeVideo.rawValue:
                        valueString = "homeVideo"
                    case MPMediaType.anyVideo.rawValue:
                        valueString = "anyVideo"
                    case MPMediaType.any.rawValue:
                        valueString = "any"
                    default:
                        valueString = "none"
                    }
                }
            }
            self.propertyValues.append((propertyKey.name, valueString))
            if let xxx = self.mediaItem?.value(forProperty: propertyKey.name) {
                print(xxx)
            }
            else {
                print("No get property value.")
            }
        }
    }
    
    func setSongs() {
        print(#function)
        self.songs = []
        let mPMediaQuery = MPMediaQuery.songs()
        if let items = mPMediaQuery.items {
//            let sortItems = items.sorted(by: { (a, b) -> Bool in
//                var lastplayA: TimeInterval = 0
//                var lastplayB: TimeInterval = 0
//                if let lastplay = a.lastPlayedDate {
//                    lastplayA = lastplay.timeIntervalSince1970
//                }
//                if let lastplay = b.lastPlayedDate {
//                    lastplayB = lastplay.timeIntervalSince1970
//                }
//                return lastplayA > lastplayB
//            })
//            print(sortItems.count)
//            self.songs = sortItems
            self.songInfoamrtionList = []
            self.idMPMediaItemList = []
            for song in items {
                let item = IdMPMediaItem(item: song)
                self.idMPMediaItemList.append(item)
//
//                let title = song.title != nil ? song.title! : ""
//                let albumTitle = song.albumTitle != nil ? song.albumTitle! : ""
//                var artsit = ""
//                if song.albumArtist != nil {
//                    artsit = song.albumArtist!
//                }
//                else if song.artist != nil {
//                    artsit = song.artist!
//                }
//                let songInformation = SongInformation(title: title, albumTitle: albumTitle, artist: artsit, lastPlayDate: song.lastPlayedDate, playCount: String(song.playCount))
//                self.songInfoamrtionList.append(songInformation)
            }
            print(self.idMPMediaItemList.count)
            print(self.songInfoamrtionList.count)
        }
    }

    func setSongs(search: String, selection: Int, selectionSort: Int) {
        print(#function + ":\(search)")

        let predicateTitle = MPMediaPropertyPredicate(value: search, forProperty: MPMediaItemPropertyTitle, comparisonType: MPMediaPredicateComparison.contains)
        let predicateAlbumTitle = MPMediaPropertyPredicate(value: search, forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: MPMediaPredicateComparison.contains)
        let predicateArtist = MPMediaPropertyPredicate(value: search, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.contains)

        self.songs = []
        let mPMediaQuery = MPMediaQuery.songs()
        switch(selection) {
        case 0:
            mPMediaQuery.addFilterPredicate(predicateTitle)
        case 1:
            mPMediaQuery.addFilterPredicate(predicateAlbumTitle)
        case 2:
            mPMediaQuery.addFilterPredicate(predicateArtist)
        default:
            mPMediaQuery.addFilterPredicate(predicateTitle)
        }
        if let items = mPMediaQuery.items {
            let sortItems = items.sorted(by: { (a, b) -> Bool in
                var result = true
                switch(selectionSort) {
                case 0:
                    result = a.title! < b.title!
                case 1:
                    result = a.playCount > b.playCount
                default:
                    result = true
                }
                return result
            })
            print(sortItems.count)
            self.songs = sortItems
        }
    }

    func onePlay(item: MPMediaItem) {
        let items: MPMediaItemCollection = MPMediaItemCollection(items: [item])
        self.player!.setQueue(with: items)
        self.player?.play()
    }
    
}

struct SongInformation: Identifiable {
    let id: UUID = UUID()
    let title: String
    let albumTitle: String
    let artist: String
    let lastPlayDate: Date?
    let playCount: String
}

struct IdMPMediaItem: Identifiable{
    let item: MPMediaItem
    let id: UUID = UUID()
}
