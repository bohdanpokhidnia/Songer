//
//  ContentView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

enum ActiveSheet {
    case addArtist
    case addMusic
}

struct ContentView: View {
    
    @State private var activeSheet: ActiveSheet = .addArtist
    @State private var showActionSheet: Bool = false
    @State private var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            TabView {
                ArtistsList()
                    .tabItem {
                        Image(systemName: "rectangle.stack.person.crop.fill")
                            .imageScale(.large)
                        Text("Artists")
                    }
                
                SongList(allListSong: true)
                    .tabItem {
                        Image(systemName: "music.note.list")
                            .imageScale(.large)
                        Text("Songs")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                        Text("Search")
                    }
                
            }
            .navigationBarTitle(Text("Songer"))
            .navigationBarItems(trailing:  Button(action: {
                showActionSheet.toggle()
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .padding(.top)
                    .padding(.leading)
                    .padding(.bottom)
            }))
            .sheet(isPresented: $showSheet) {
                switch(activeSheet) {
                case .addArtist:
                    AddArtistView()
                case .addMusic:
                    AddMusicView()
                }
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select action"), buttons: [.default(Text("Add artist"), action: {
                    activeSheet = .addArtist
                    showSheet.toggle()
                }), .default(Text("Add music"), action: {
                    activeSheet = .addMusic
                    showSheet.toggle()
                }), .cancel()])
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
