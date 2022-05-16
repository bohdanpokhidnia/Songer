//
//  ItunesAPI.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 21.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation
import UIKit

enum SourceService {
    case itunesSearch
    case itunesLookupTrackById
    case deezerSearch
    case musicMatchSearch
    case musicMatchLyrics
}

class NetworkService {
    private var urlComponents = URLComponents()
    
    private let itunesPath: String = "itunes.apple.com"
    private let deezerPath: String = "api.deezer.com"
    private let musicMatchPath = "api.musixmatch.com"
    
    private let musicMatchApiKey = "a5bb3109784f69ecefdd72d7f244003e"
    
    init(_ type: SourceService) {
        urlComponents.scheme = "https"
        
        switch type {
        case .itunesSearch:
            urlComponents.host = itunesPath
            urlComponents.path = "/search"
            
        case .itunesLookupTrackById:
            urlComponents.host = itunesPath
            urlComponents.path = "/lookup"
            
        case .deezerSearch:
            urlComponents.host = deezerPath
            urlComponents.path = "/search"
            
        case .musicMatchSearch:
            urlComponents.host = musicMatchPath
            urlComponents.path = "/ws/1.1/track.search"
            
        case .musicMatchLyrics:
            urlComponents.host = musicMatchPath
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
        
        URLSession.shared.dataTask(with: url) { data, response, error in
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
        }.resume()
    }
    
    func requestSearchTrack(artistName: String, trackName: String, completion: @escaping (Result<Data, Error>) -> ()) {
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: musicMatchApiKey),
            URLQueryItem(name: "q_artist", value: artistName),
            URLQueryItem(name: "q_track", value: trackName)
        ]
        
        guard let absoluteStringUrl = urlComponents.url?.absoluteString else { return }
        guard let url = URL(string: absoluteStringUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
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
        }.resume()
    }
    
    func requestURLImage(urlString: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
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
        }.resume()
    }
    
    func requestArist(query: String, completion: @escaping (Result<Data, Error>) -> ()){
        urlComponents.queryItems  = [
            URLQueryItem(name: "q", value: query)
        ]
        
        guard let absoluteStringURL = urlComponents.url?.absoluteString else { return }
        guard let searchURL = URL(string: absoluteStringURL) else { return }
        
        URLSession.shared.dataTask(with: searchURL) { data, response, error in
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
        }.resume()
    }
    
    func requestSongsByArtist(query: String, completion: @escaping (Result<Data, Error>) -> ()) {
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: query),
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "entity", value: "song"),
            URLQueryItem(name: "lang", value: "ru_ru"),
            URLQueryItem(name: "limit", value: "200")
        ]
        
        guard let absoluteStringURL = urlComponents.url?.absoluteString else { return }
        guard let searchURL = URL(string: absoluteStringURL) else { return }
        
        URLSession.shared.dataTask(with: searchURL) { data, response, error in
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
        }.resume()
    }
    
    func requestChart(completion: @escaping (Result<Data, Error>) -> ()) {
        let url = "https://rss.applemarketingtools.com/api/v2/ua/music/most-played/100/songs.json"
        guard let searchURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: searchURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("[dev] Status code: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
    
    func requestTrackById(id: Int, completion: @escaping (Result<Data, Error>) -> ()) {
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: "\(id)")
        ]
        
        guard let absoluteStringURL = urlComponents.url?.absoluteString else { return }
        guard let searchURL = URL(string: absoluteStringURL) else { return }
        
        URLSession.shared.dataTask(with: searchURL) { data, response, error in
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
        }.resume()
    }
}
