//
//  SearchView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var songs: [SongInfo] = []
    @State private var searchText: String = ""
    @State private var showSong: Bool = false
    
    
    private var imageCache = ImageCache.getImageCache()
    
    var body: some View {
        VStack{
            SearchBar(text: $searchText, placeholder: "Search") {
                
                self.searchSongs()
                
            }
            List {
                ForEach(songs) { song in
                    
                    Button(action: {
                        showSong.toggle()
                    }, label: {
                        SongCell(urlImage: song.artworkUrl350,
                                songName: song.trackName,
                                author: song.artistName,
                                trackPreviewUrl: song.trackViewUrl)
                        {
                            self.addSong(song)
                        }
                    })
                    .sheet(isPresented: $showSong) {
                        SongInfoView(songInfo: song)
                    }
                }
            }
        }
        
    }
    
    private func addSong(_ song: SongInfo) {
        
        let newSong = Music(context: self.viewContext)
        
        if let imageData = imageCache.get(forKey: song.artworkUrl350)?.jpegData(compressionQuality: 1.0) {
            newSong.pictures = imageData
        }
        
        newSong.name = song.trackName
        newSong.artist = song.artistName
        newSong.album = song.album
        newSong.text = "Text song..."
        newSong.date = "song.stringDate"
        newSong.previewUrl = song.trackViewUrl 
        
        
        do {
            try self.viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func searchSongs() {
        self.songs.removeAll()
        
        ItunesDataFetcher.fetchSongsByArtist(query: searchText, sourceType: .itunesSearch) { (songs) in
            guard let songs = songs else { return }
            
            withAnimation {
                self.songs = songs
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
