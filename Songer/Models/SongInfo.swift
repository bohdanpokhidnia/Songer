//
//  SongInfoModel.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 21.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation
import UIKit

struct SongInfoModel: Codable {
    let resultCount: Int
    let results: [SongInfo]
}

struct SongInfo: Codable, Identifiable {
    let id = UUID()
    
    let wrapperType: String
    let kind: String
    let artistId: Int
    let collectionId: Int
    let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let collectionCensoredName: String
    let trackCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let trackViewUrl: String
    let previewUrl: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String
    let collectionExplicitness: String
    let trackExplicitness: String
    let discCount: Int
    let discNumber: Int
    let trackCount: Int
    let trackNumber: Int
    let trackTimeMillis: Int
    let primaryGenreName: String
}

extension SongInfo {
    
    var artWorkURL: String {
        var url = self.artworkUrl100
        
        let range = url.index(url.endIndex, offsetBy: -13)..<url.endIndex
        
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
    
    var cover: UIImage {
        var pictures = UIImage(named: "cover")!
        
        ItunesService().fetchURLImage(urlString: self.artWorkURL) { (image) in
            pictures = image
        }
        
        return pictures
    }
}
