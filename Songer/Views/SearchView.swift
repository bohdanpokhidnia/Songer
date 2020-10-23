//
//  SearchView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = "Oxxxymiron"
    @State private var songs: [SongInfo] = []
    
    var body: some View {
        VStack{
            HStack{
                TextField("Artist name", text: $searchText)
                Spacer()
                Button("Search") {
                    
                    ItunesService().fetchSongsByArtist(query: searchText) { (songs) in
                        self.songs = songs
                    }
                    
                }
            }.padding()
            
            List {
                ForEach(songs) { song in
                    
                    Button(action: {
                        print(song.trackName)
                    }, label: {
                        SongRow(urlImage: song.artWorkURL, songName: song.trackName, author: song.artistName)
                    })
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
