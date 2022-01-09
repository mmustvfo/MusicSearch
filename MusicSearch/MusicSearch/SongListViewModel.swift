//
//  SongListViewModel.swift
//  MusicSearch
//
//  Created by Mustafo on 01/04/21.
//
import Combine
import Foundation
import SwiftUI

class SongListViewModel:ObservableObject{
    @Published var searchTerm:String = ""
    @Published public private(set) var songs:[SongViewModel] = []
    
    
    private let dataModel:DataModel = DataModel()
    private var disposlables = Set<AnyCancellable>()
    private let artWorkLoader: ArtWorkLoader = ArtWorkLoader()
    
    
    
    
    init(){
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:))
            .store(in: &disposlables)
    }
    
    private func loadSongs(searchTerm:String){
        songs.removeAll()
        artWorkLoader.reset()
        
        dataModel.loadSongs(searchTerm: searchTerm){ songs in
            songs.forEach{
                self.appendingSong(song: $0)
            }
        }
    }
    
    private func appendingSong(song:Song){
        let songViewModel = SongViewModel(song: song)
        DispatchQueue.main.async {
            self.songs.append(songViewModel)
        }
        
        artWorkLoader.loadArtWork(forSong: song){ image in
            DispatchQueue.main.async {
                songViewModel.artwork = image
            }
      
        }
    }
    
    
}



class SongViewModel:Identifiable,ObservableObject{
    var id:Int
    var trackName:String
    var artistName:String
    @Published var artwork: Image?
    
    
    init(song:Song) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
    }
    
}
