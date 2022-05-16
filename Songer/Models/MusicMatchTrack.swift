//
//  MusicMatchTrack.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 20.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

struct MusicMatchSearchResponse: Decodable {
    var message: Message
}

struct Message: Decodable {
    var header: Header
    var body: Body
}

struct Header: Decodable {
    var statusCode: Int
    var executeTime: Double
    var available: Int

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case executeTime = "execute_time"
        case available
    }
}

struct Body: Decodable {
    var trackList: [TrackList]

    enum CodingKeys: String, CodingKey  {
        case trackList = "track_list"
    }
}

struct TrackList: Decodable {
    var track: Track
}

struct Track : Decodable {
    var trackId: Int
    var trackName: String
    var hasLyrics: Int
    var artistId: Int
    var artistName: String

    enum CodingKeys: String, CodingKey {
        case trackId = "track_id"
        case trackName = "track_name"
        case hasLyrics = "has_lyrics"
        case artistId = "artist_id"
        case artistName = "artist_name"
    }
}

extension Track {
    
    var isLyrics: Bool {
        return self.hasLyrics > 0
    }
    
}
