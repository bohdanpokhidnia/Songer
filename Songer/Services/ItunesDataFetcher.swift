//
//  ItunesDataFetcher.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation
import UIKit

class ItunesDataFetcher {
    let itunesService = ItunesService()
    
    func fetchSongsByArtist(query: String, response: @escaping ([SongInfo]?) -> ()) {
        itunesService.requestSongsByArtist(query: query) { (result) in
            switch result {
            
            case .success(let data):
                do {
                    let songs = try JSONDecoder().decode(SearchResponse.self, from: data)
                    
                    response(songs.results)
                } catch let jsonError {
                    print("Failed to decode: ", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func fetchTrackByArtist(artistName: String, trackName: String, response: @escaping (SongInfo?) -> ()) {
        
        fetchSongsByArtist(query: artistName) { (songs) in
            guard let songs = songs else { return }
        
            for song in songs {
                if song.trackName == trackName {
                    response(song)
                    return
                }
            }
            
            response(nil)
        }
    }
    
    func fetchCoverFromUrl(url: String, response: @escaping (UIImage?) -> ()) {
        itunesService.requestURLImage(urlString: url) { (result) in
            switch result {
            
            case .success(let data):
                response(UIImage(data: data))
            case .failure(_):
                response(nil)
            }
        }
    }
}
