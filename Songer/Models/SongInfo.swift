//
//  SongInfoModel.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 21.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import UIKit

struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [SongInfo]
}

struct SongInfo: Decodable, Identifiable {
    let id = UUID()
    
    let wrapperType: String
    let kind: String
    let artistId: Int
    let collectionId: Int?
    let trackId: Int
    let artistName: String
    let collectionName: String?
    let trackName: String
    let collectionCensoredName: String?
    let trackCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String?
    let trackViewUrl: String
    let previewUrl: String?
    let artworkUrl30: String
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String
    let collectionExplicitness: String
    let trackExplicitness: String
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let primaryGenreName: String
}

extension SongInfo {
    
    var artworkUrl350: String {
        var url = self.artworkUrl30
        
        let range = url.index(url.endIndex, offsetBy: -11)..<url.endIndex
        
        url.removeSubrange(range)
        
        url.insert(contentsOf: "350x350bb.jpg", at: url.endIndex)
        
        return url
    }
    
    var stringDate: String {
        
        var releaseDate = self.releaseDate
        
        let range = releaseDate.index(releaseDate.startIndex, offsetBy: +10)..<releaseDate.endIndex
        
        releaseDate.removeSubrange(range)
        
        return releaseDate.replacingOccurrences(of: "-", with: ".")
        
    }
    
    var roundPrice: String? {
        
        if let price = self.trackPrice {
            
            return String(format: "%.2f", price)
        }
        
        return nil
    }
    
    var album : String {
        let name = "Single - "
        
        if let nameAlbum = self.collectionName {
            return nameAlbum
        } else {
            return name + self.trackName
        }
    }
}
