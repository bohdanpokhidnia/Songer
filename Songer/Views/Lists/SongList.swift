//
//  SongList.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 24.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI


struct SongList: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showMusicView: Bool = false
    @State private var showAddMusicView: Bool = false
    
    var artistName: String?
    var allListSong: Bool?
    
    var body: some View {
        
        FilteredList(filteredKey: "artist", filteredValue: artistName ?? String()){ (song: Music) in
            Button(action: {
                showMusicView.toggle()
            }, label: {
                
                if let allListSong = allListSong {
                    
                    if allListSong {
                        SongRow(pictures: UIImage(data: song.pictures)!,
                                songName: song.name, author: song.artist)
                    }
                    
                } else {
                    SongRow(pictures: UIImage(data: song.pictures)!,
                            songName: song.name)
                }
            }).sheet(isPresented: $showMusicView){
                SongView().environmentObject(song)
            }
        }
        .navigationBarTitle(Text(artistName ?? ""), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            showAddMusicView.toggle()
        }, label: {
            Image(systemName: "plus")
                .imageScale(.large)
                .padding(.vertical)
                .padding(.leading)
        }).sheet(isPresented: $showAddMusicView, content: {
            AddMusicView().environment(\.managedObjectContext, managedObjectContext)
        }))
        
    }
}

struct SongList_Previews: PreviewProvider {
    
    @Environment(\.managedObjectContext) static var managedObjectContext
    
    static var previews: some View {
        SongList(artistName: "Test").environment(\.managedObjectContext, managedObjectContext)
    }
}
