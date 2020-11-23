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
    
    var body: some View {
        VStack {
            SongInfoCell(songInfo: songInfo)
            
            Divider()
        }
        
    }
}

struct SongInfoCell: View {
    
    var songInfo: SongInfo
    
    @State private var price: String = "Free"
    @State private var date: String = "00.00.0000"
    
    var body: some View {
        HStack(alignment: .top) {
            URLImageView(urlString: songInfo.artworkUrl350, width: 150, height: 150)
            
            VStack(alignment: .leading) {
                
                Text(songInfo.trackName)
                    .font(.headline)
                
                Text(songInfo.artistName)
                    .font(.body)
                
                Text(songInfo.album)
                    .font(.body)
                
                Text("Genre: \(songInfo.primaryGenreName)")
                    .font(.body)
                
                Text("Price iTunes: \(price)")
                    .font(.body)
                
                Text("Release: \(date)")
                    .font(.body)
            }
            .frame(maxHeight: .infinity)
            
            Spacer()
        }.frame(maxWidth: .infinity)
        .frame(maxHeight: 150)
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
    private static let song = SongInfo(wrapperType: "song", kind: "song", artistId: 123, collectionId: 123, trackId: 123, artistName: "Oxxxymiron", collectionName: "Горгород", trackName: "Очень большое название для песни, которая ничего не стоит", collectionCensoredName: "Горгород", trackCensoredName: "Очень большое название для песни", artistViewUrl: "Url", collectionViewUrl: "url", trackViewUrl: "url", previewUrl: "url", artworkUrl30: artworkLink, artworkUrl60: "artwork", artworkUrl100: "artwork", collectionPrice: 22.2, trackPrice: 22.2, releaseDate: "22.10.2020", collectionExplicitness: "explicitness", trackExplicitness: "explicitness", discCount: 1, discNumber: 2, trackCount: 3, trackNumber: 4, trackTimeMillis: 123456, primaryGenreName: "Hip-hop")
    
    
    static var previews: some View {
        
        
        SongInfoView(songInfo: song)
    }
}

