//
//  ItunesAPI.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 21.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation
import UIKit

enum ServiceType {
    case itunesSearch
    case deezerSearch
    case musicMatchSearch
    case musicMatchLyrics
}

class NetworkService {
    
    private var urlComponents = URLComponents()
    
    private var musicMatchApiKey = "a5bb3109784f69ecefdd72d7f244003e"
    
    init(_ type: ServiceType) {
        urlComponents.scheme = "https"
        
        switch type {
        case .itunesSearch:
            urlComponents.host = "itunes.apple.com"
            urlComponents.path = "/search"
        case .deezerSearch:
            urlComponents.host = "api.deezer.com"
            urlComponents.path = "/search"
        case .musicMatchSearch:
            urlComponents.host = "api.musixmatch.com"
            urlComponents.path = "/ws/1.1/track.search"
        case .musicMatchLyrics:
            urlComponents.host = "api.musixmatch.com"
            urlComponents.path = "/ws/1.1/track.lyrics.get"
        }
        
    }
    
    func requestLyricsByTrackId(trackId: Int, completion: @escaping (Result<Data, Error>) -> ()) {
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: musicMatchApiKey),
            URLQueryItem(name: "track_id", value: String(trackId))
        ]
        
        guard let absoluteStringUrl = urlComponents.url?.absoluteString else { return }
        
        guard let url = URL(string: absoluteStringUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Failed when request lyrics from MusicMatch: \(error)")
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
        
        task.resume()
    }
    
    func requestSearchTrack(artistName: String, trackName: String, completion: @escaping (Result<Data, Error>) -> ()) {
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: musicMatchApiKey),
            URLQueryItem(name: "q_artist", value: artistName),
            URLQueryItem(name: "q_track", value: trackName)
        ]
        
        guard let absoluteStringUrl = urlComponents.url?.absoluteString else { return }
        
        print(absoluteStringUrl)
        
        guard let url = URL(string: absoluteStringUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error{
                    print("Failed when request search track from MusicMatch: \(error)")
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
    
    func requestURLImage(urlString: String, completion: @escaping (Result<Data, Error>) -> ()) {
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
    
    func requestArist(query: String, completion: @escaping (Result<Data, Error>) -> ()){
        urlComponents.queryItems  = [
            URLQueryItem(name: "q", value: query)
        ]
        
        guard let absoluteStringURL = urlComponents.url?.absoluteString else { return }
        
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
    
    func requestSongsByArtist(query: String, completion: @escaping (Result<Data, Error>) -> ()) {
        
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: query),
            URLQueryItem(name: "entity", value: "musicTrack"),
            URLQueryItem(name: "limit", value: "200")
        ]
        
        guard let absoluteStringURL = urlComponents.url?.absoluteString else { return }
        
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
