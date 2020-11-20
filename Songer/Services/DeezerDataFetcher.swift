//
//  DeezerDataFetcher.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 19.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import UIKit

class DeezerDataFetcher {
    private let deezerNetworkService = NetworkService(.deezerSearch)
    
    func fetchArtistPictureURL(artistName: String, completion: @escaping (String?) -> ()) {
        deezerNetworkService.requestArist(query: artistName) { (result) in
            switch result {
            case .success(let data):
                do {
                    let artistList = try JSONDecoder().decode(SearchArtistResponse.self, from: data)
                    
                    completion(artistList.data.first?.artist.pictures)
                    
                } catch let jsonError {
                    print("Failed to decode: ", jsonError)
                }
            case.failure(_):
                completion(nil)
            }
        }
    }
    
    func fetchArtistPicture(artistName: String, response: @escaping (UIImage?) -> ()) {
        
        fetchArtistPictureURL(artistName: artistName) { (url) in
            
            guard let url = url else { return }
            
            self.deezerNetworkService.requestURLImage(urlString: url) { (result) in
                switch result {
                case .success(let data):
                    response(UIImage(data: data))
                case .failure(_):
                    response(nil)
                }
            }
        }
    }
}
