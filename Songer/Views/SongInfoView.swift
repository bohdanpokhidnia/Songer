//
//  SongInfoView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct SongInfoView: View {
    
    var songInfo: SongInfo
    
    @State private var price: String = "Free"
    @State private var date: String = "20.01.2000"
    
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                
                URLImageView(urlString: songInfo.artworkUrl350, width: 150, height: 150)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(songInfo.trackName)
                        .lineLimit(1)
                        .font(.headline)
                    Text(songInfo.artistName)
                    Text("Genre: \(songInfo.primaryGenreName)")
                    Text("Price iTunes: \(price)")
                        .font(.callout)
                    Text("Release: \(date)")
                        .font(.callout)
                }
                Spacer()
            }
            
            Spacer()
        }.padding(.top)
        .onAppear {
            if let roundPrice = songInfo.roundPrice {
                price = roundPrice + " $"
            }
            
            if let date = StringDateFormatter().formatStringDate(songInfo.stringDate, "yyyy.MM.dd", .long) {
                self.date = date
            }
        }
    }
}

struct SongInfoView_Previews: PreviewProvider {
    
    private static let artworkLink = "https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/47/0c/02/470c024c-b39a-fa7c-f4e9-cc2a8c392638/source/350x350bb.jpg"
    
    private static let song = SongInfo(wrapperType: "song", kind: "song", artistId: 123, collectionId: 123, trackId: 123, artistName: "Oxxxymiron", collectionName: "Горгород", trackName: "Где нас нет", collectionCensoredName: "Горгород", trackCensoredName: "Где нас нет", artistViewUrl: "Url", collectionViewUrl: "url", trackViewUrl: "url", previewUrl: "url", artworkUrl30: artworkLink, artworkUrl60: "artwork", artworkUrl100: "artwork", collectionPrice: 22.2, trackPrice: 22.2, releaseDate: "22.10.2020", collectionExplicitness: "explicitness", trackExplicitness: "explicitness", discCount: 1, discNumber: 2, trackCount: 3, trackNumber: 4, trackTimeMillis: 123456, primaryGenreName: "Hip-hop")
    
    static var previews: some View {
        
        
        SongInfoView(songInfo: song)
    }
}
