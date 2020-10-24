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
    @State private var showSong: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                TextField("Enter text", text: $searchText)
                Spacer()
                Button("Search") {
                    
                    songs.removeAll()
                    
                    ItunesDataFetcher().fetchSongsByArtist(query: searchText) { (songs) in
                        guard let songs = songs else { return }
                        
                        self.songs = songs
                    }
                    
                }
            }.padding()
            
            List {
                ForEach(songs) { song in
                    
                    Button(action: {
                        print(song.trackName)
                        showSong.toggle()
                    }, label: {
                        SongRow(urlImage: song.artworkUrl350, songName: song.trackName, author: song.artistName)
                    })
                    .sheet(isPresented: $showSong) {
                        SongInfoView(songInfo: song)
                    }
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
