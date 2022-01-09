//
//  ArtWorkLoader.swift
//  MusicSearch
//
//  Created by Mustafo on 03/04/21.
//

import Foundation
import SwiftUI

class ArtWorkLoader{
    private var dataTasks:[URLSessionDataTask] = []
    
    func loadArtWork(forSong song:Song,completion:@escaping((Image?)-> Void)) {
        guard let imagerUrl = URL(string: song.artworkUrl) else {
            completion(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: imagerUrl) { data,_,_ in
            guard let data = data,let uIImage = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            let image = Image(uiImage: uIImage)
            completion(image)
        }
        dataTasks.append(dataTask)
        dataTask.resume()
    }
    func reset(){
        dataTasks.forEach{$0.cancel()}
        dataTasks.removeAll()
    }
    
}
