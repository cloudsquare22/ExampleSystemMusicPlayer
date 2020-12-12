//
//  ExampleSystemMusicPlayerApp.swift
//  ExampleSystemMusicPlayer
//
//  Created by Shin Inaba on 2020/12/12.
//

import SwiftUI

@main
struct ExampleSystemMusicPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Music())
        }
    }
}
