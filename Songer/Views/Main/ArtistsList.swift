//
//  ListView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct ArtistsList: View {
    @FetchRequest(entity: MusicArtist.entity(), sortDescriptors: []) var artists: FetchedResults<MusicArtist>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        List {
            ForEach(self.artists) { artist in
                
                NavigationLink(destination: SongList(artistName: artist.name),
                               label: {
                                ArtistRow(artistName: artist.name, artistPictures: UIImage(data: artist.pictures)!)
                               })
                
            }.onDelete { indexSet in
                let deleteArtist = self.artists[indexSet.first!]
                
                self.managedObjectContext.delete(deleteArtist)
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.listStyle(PlainListStyle())
        
    }
}

struct ArtistsList_Previews: PreviewProvider {
    
    @Environment(\.managedObjectContext) static var managedObjectContext
    
    
    static var previews: some View {
        ArtistsList().environment(\.managedObjectContext, managedObjectContext)
    }
}
