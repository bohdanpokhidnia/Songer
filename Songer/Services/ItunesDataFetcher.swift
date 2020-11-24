//
//  ItunesDataFetcher.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//


import UIKit

class ItunesDataFetcher {
    
    class func fetchSongsByArtist(query: String, sourceType: SourceService, response: @escaping ([SongInfo]?) -> ()) {
        NetworkService(sourceType).requestSongsByArtist(query: query) { result in
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
    
    class func fetchTrackByArtist(artistName: String, trackName: String, sourceType: SourceService,  response: @escaping (SongInfo?) -> ()) {
        
        fetchSongsByArtist(query: artistName, sourceType: sourceType) { songs in
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
    
    class func fetchTrackById(trackId: Int, sourceType: SourceService, response: @escaping () -> ()) {
        
    }
    
    func fetchChart(response: @escaping ([TrackChart]?) -> ()) {
        NetworkService(.itunesSearch).requestChart { result in
            switch result {
            case .success(let data):
                do {
                    let answer = try JSONDecoder().decode(ResponseChart.self, from: data)
                    response(answer.feed.results)
                } catch {
                    print("Failed fetch chart: \(error)")
                }
            case .failure(_):
                response(nil)
            }
        }
    }
    
    class func fetchCoverFromUrl(url: String, sourceType: SourceService, response: @escaping (UIImage?) -> ()) {
         NetworkService(sourceType).requestURLImage(urlString: url) { result in
            switch result {
            
            case .success(let data):
                response(UIImage(data: data))
            case .failure(_):
                response(nil)
            }
        }
    }
}
