//
//  MusicMatchDataFetcher.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 20.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation

class MusicMatchDataFetcher {
    
    class func fetchTrackByNameAndArtist(artistName: String, trackName: String, response: @escaping (Track?) -> ()) {
        let searchMusicMatch = NetworkService(.musicMatchSearch)
        
        searchMusicMatch.requestSearchTrack(artistName: artistName, trackName: trackName) { result in
            switch result {
            case .success(let data):
                do {
                    let answer = try JSONDecoder().decode(MusicMatchSearchResponse.self, from: data)
                    if answer.message.header.available > 0 {
                        response(answer.message.body.trackList.first?.track)
                    }
                } catch {
                    print("[dev] Failure to decode, error: \(error)")
                }
                
            case .failure(_):
                print("[dev] Error when fetch track by name and artist")
                response(nil)
            }
        }
    }
    
    class func fetchLyricsByTrackId(trackId: Int, response: @escaping (String?) -> ()) {
        let lyricsMusicMatch = NetworkService(.musicMatchLyrics)
        
        lyricsMusicMatch.requestLyricsByTrackId(trackId: trackId) { result in
            switch result {
            case .success(let data):
                do {
                    let answer = try JSONDecoder().decode(MusicMatchLyricsResponse.self, from: data)
                    response(answer.message.body.lyrics.text)
                } catch {
                    print("[dev] Error when fetch track by trackId")
                }
                
            case .failure(_):
                response(nil)
            }
        }
    }
}
