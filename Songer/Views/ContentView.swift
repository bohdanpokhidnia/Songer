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
                ChartView(chart: [])
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                            .font(.largeTitle)
                        Text("Chart")
                    }
                ArtistsList()
                    .tabItem {
                        Image(systemName: "rectangle.stack.person.crop.fill")
                            .font(.largeTitle)
                        Text("Artists")
                    }
                
                SongList()
                    .tabItem {
                        Image(systemName: "music.note.list")
                            .font(.largeTitle)
                        Text("Songs")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
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
