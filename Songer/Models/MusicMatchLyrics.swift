//
//  MusicMatchLyrics.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 20.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

struct MusicMatchLyricsResponse: Codable {
    var message: LyricsMessage
}

struct LyricsMessage: Codable {
    var body: LyricsBody
}

struct LyricsBody: Codable {
    var lyrics: Lyrics
}

struct Lyrics: Codable {
    var lyricsBody: String
    
    enum CodingKeys: String, CodingKey {
        case lyricsBody = "lyrics_body"
    }
}

extension Lyrics {
    var text: String {
        var lyrics = self.lyricsBody
        
        let range = lyrics.index(lyrics.endIndex, offsetBy: -54) ..< lyrics.endIndex
        
        lyrics.removeSubrange(range)
        
        return lyrics
    }
}
