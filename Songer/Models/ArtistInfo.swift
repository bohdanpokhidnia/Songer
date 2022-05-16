//
//  ArtistInfo.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 19.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct SearchArtistResponse: Decodable {
    let data: [Info]
}

struct Info : Decodable {
    let artist: ArtistInfo
}

struct ArtistInfo: Decodable {
    let name: String
    let pictures: String
    
    enum CodingKeys: String, CodingKey {
        case name, pictures = "picture_xl"
    }
}
