//
//  ItunesAPI.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 21.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation
import UIKit

class ItunesService {
    
    private var searchURLComponents = URLComponents()
    
    
    init() {
        searchURLComponents.scheme = "https"
        searchURLComponents.host = "itunes.apple.com"
        searchURLComponents.path = "/search"
    }
    
    func fetchURLImage(urlString: String, completion: @escaping (UIImage) -> () ) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Status code: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    
                    completion(image)
                }
            }
            
        }
        
        task.resume()
    }
    
    func fetchTrackByArtist(artistName: String, songName: String, completion: @escaping (SongInfo) -> ()) {
        
        fetchSongsByArtist(query: artistName) { (songs) in
            
            for song in songs {
                
                if song.trackName == songName {
                    completion(song)
                    return
                }
            }
            
        }
        
    }
    
    func fetchSongsByArtist(query: String, completion: @escaping ([SongInfo]) -> () ) {
        
        searchURLComponents.queryItems = [
            URLQueryItem(name: "term", value: query),
            URLQueryItem(name: "entity", value: "song"),
            URLQueryItem(name: "limit", value: "200")
        ]
        
        guard let absoluteStringURL = searchURLComponents.url?.absoluteString else { return }
        
        guard let searchURL = URL(string: absoluteStringURL) else { return }
        
        print(absoluteStringURL)
        
        let task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
            
            var songs: [SongInfo] = []
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                
                if response.statusCode != 200 {
                    print("Status code: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return }
            
            do {
                let answer = try JSONDecoder().decode(SongInfoModel.self, from: data)

                songs = answer.results

            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                completion(songs)
            }
        }
        
        task.resume()
    }
}
