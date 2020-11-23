//
//  MusicMatchLyrics.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 20.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

struct MusicMatchLyricsResponse: Decodable {
    var message: LyricsMessage
}

struct LyricsMessage: Decodable {
    var body: LyricsBody
}

struct LyricsBody: Decodable {
    var lyrics: Lyrics
}

struct Lyrics: Decodable {
    var lyricsBody: String
    
    enum CodingKeys: String, CodingKey {
        case lyricsBody = "lyrics_body"
    }
}

extension Lyrics {
    var text: String {
        var lyrics = self.lyricsBody
        
        let range = lyrics.index(lyrics.endIndex, offsetBy: -70) ..< lyrics.endIndex
        
        lyrics.removeSubrange(range)
        
        return lyrics
    }
}
