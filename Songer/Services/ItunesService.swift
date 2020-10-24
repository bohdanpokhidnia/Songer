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
    
    func requestURLImage(urlString: String, completion: @escaping (Result<Data, Error>) -> () ) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    print("Failed get image from url: ", error)
                    completion(.failure(error))
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        print("Status url image code: \(response.statusCode)")
                    }
                }
                
                guard let data = data else { return }
                
                completion(.success(data))
            }
            
        }
        
        task.resume()
    }
    
//    func requestTrackByArtist(artistName: String, songName: String, completion: @escaping (SongInfo) -> ()) {
//
//        requestSongsByArtist(query: artistName) { (songs) in
//
//
//
//            switch result {
//
//            case .success(let songs):
//                songs.map { (song)  in
//                    if song.trackName == songName {
//                        completion(song)
//                        return
//                    }
//                }
//            case .failure(let error):
//                print("error: ", error)
//            }
//
//        }
//
//    }
    
    func requestSongsByArtist(query: String, completion: @escaping (Result<Data, Error>) -> () ) {
        
        searchURLComponents.queryItems = [
            URLQueryItem(name: "term", value: query),
            URLQueryItem(name: "entity", value: "musicTrack"),
            URLQueryItem(name: "limit", value: "200")
        ]
        
        guard let absoluteStringURL = searchURLComponents.url?.absoluteString else { return }
        
        guard let searchURL = URL(string: absoluteStringURL) else { return }
        
        let task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(error))
                }
                
                if let response = response as? HTTPURLResponse {
                    
                    if response.statusCode != 200 {
                        print("Status code: \(response.statusCode)")
                    }
                }
                
                guard let data = data else { return }
                
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}
