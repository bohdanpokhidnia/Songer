//
//  TrackChart.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 24.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct ResponseChart: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [TrackChart]
}

struct TrackChart: Decodable, Identifiable {
    let uiid = UUID()
    
    let artistName: String
    let id: String
    let releaseDate: String?
    let name: String
    let kind: String
    let artistId: String
    let contentAdvisoryRating: String?
    let artistUrl: String
    let artworkUrl100: String
    let url: String
}

extension TrackChart {
    
    static let mockTrack = TrackChart(
        artistName: "KALUSH",
        id: "1614859013",
        releaseDate: "2022-03-10",
        name: "Stefania (Kalush Orchestra)",
        kind: "songs",
        artistId: "1482422674",
        contentAdvisoryRating: nil,
        artistUrl: "https://music.apple.com/ua/artist/kalush/1482422674",
        artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/dd/07/db/dd07dbab-7900-9a38-403f-b2ee85101afc/196589018380.jpg/100x100bb.jpg",
        url: "https://music.apple.com/ua/album/stefania-kalush-orchestra/1614859010?i=1614859013"
    )
    
}
