//
//  MusicSearchApp.swift
//  MusicSearch
//
//  Created by Mustafo on 01/04/21.
//

import SwiftUI

@main
struct MusicSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SongListViewModel())
        }
    }
}
