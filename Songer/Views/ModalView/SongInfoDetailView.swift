//
//  SongInfoDetailView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 20.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct SongInfoDetailView: View {
    
    var songInfo: SongInfo
    
    var body: some View {
        
        List {
            HStack {
                URLImageView(urlString: songInfo.artworkUrl350, width: 350, height: 350)
            }
            .frame(maxWidth: .infinity)
            
            Text("Name: \(songInfo.trackName)")
            Text("Artist: \(songInfo.artistName)")
            Text("Album: \(songInfo.album)")
            Text("Price: \(songInfo.roundPrice ?? "Free")")
            Text("Genre: \(songInfo.primaryGenreName)")
            Text("Release date: \(songInfo.stringDate)")
        }
        
    }
}

struct SongInfoDetailView_Previews: PreviewProvider {
    
    private static let artworkLink = "https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/47/0c/02/470c024c-b39a-fa7c-f4e9-cc2a8c392638/source/350x350bb.jpg"
    
    static var previews: some View {
       SongInfoDetailView(songInfo:  SongInfo(wrapperType: "song",
                                      kind: "song",
                                      artistId: 123,
                                      collectionId: 123,
                                      trackId: 123,
                                      artistName: "Oxxxymiron",
                                      collectionName: "Горгород",
                                      trackName: "Где нас нет",
                                      collectionCensoredName: "Горгород",
                                      trackCensoredName: "Где нас нет",
                                      artistViewUrl: "Url",
                                      collectionViewUrl: "url",
                                      trackViewUrl: "url",
                                      previewUrl: "url",
                                      artworkUrl30: artworkLink,
                                      artworkUrl60: "artwork",
                                      artworkUrl100: "artwork",
                                      collectionPrice: 22.2,
                                      trackPrice: 22.2,
                                      releaseDate: "22.10.2020",
                                      collectionExplicitness: "explicitness",
                                      trackExplicitness: "explicitness",
                                      discCount: 1,
                                      discNumber: 2,
                                      trackCount: 3,
                                      trackNumber: 4,
                                      trackTimeMillis: 123456,
                                      primaryGenreName: "Hip-hop"))
    }
}
