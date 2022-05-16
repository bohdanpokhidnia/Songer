//
//  DeezerDataFetcher.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 19.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import UIKit

class DeezerDataFetcher {
    
    class func fetchArtistPictureUrl(artistName: String, sourceType: SourceService, completion: @escaping (String?) -> ()) {
        NetworkService(sourceType).requestArist(query: artistName) { result in
            switch result {
            case .success(let data):
                do {
                    let artistList = try JSONDecoder().decode(SearchArtistResponse.self, from: data)
                    completion(artistList.data.first?.artist.pictures)
                    
                } catch let jsonError {
                    print("[dev] Failed to decode: ", jsonError)
                }
            case.failure(_):
                completion(nil)
            }
        }
    }
    
    class func fetchArtistPicture(artistName: String, sourceType: SourceService, response: @escaping (UIImage?) -> ()) {
        fetchArtistPictureUrl(artistName: artistName, sourceType: sourceType) { url in
            guard let url = url else { return }
            
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
}
