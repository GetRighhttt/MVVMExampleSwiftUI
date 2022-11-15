//
//  SongViewModel.swift
//  MvvmMusic
//
//  Created by Stefan Bayne on 11/15/22.
//

import Foundation
import SwiftUI
import Combine

class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published public private(set) var songs: [SongViewModel] = [] // view can read list but not modify it
    
    private let dataModel: DataModel = DataModel()
    private var disposables = Set<AnyCancellable>()
    
    init() { // observation that updates model list when the search changes.
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:))
            .store(in: &disposables)
    }
    
    private func loadSongs(searchTerm: String) {
        songs.removeAll()
        
        dataModel.loadSongs(searchTerm: searchTerm) { songs in
            songs.forEach {
                self.appendSong(song: $0)
            }
        }
    }
    
    private func appendSong(song: SongModel) {
        let songViewModel = SongViewModel(song: song)
        DispatchQueue.main.async {
            self.songs.append(songViewModel)
        }
    }
}

class SongViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistName: String
    @Published var artwork: Image?
    
    init(song: SongModel) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
    }
    
}
