//
//  DatabaseManager.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 14.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    
    private var managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func addArtist(artistName: String, artistPictures: Data) {
        let artist = MusicArtist(context: self.managedObjectContext)
        
        artist.name = artistName
        artist.pictures = artistPictures
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func addSong(name: String, artist: String, album: String, pictures: Data, text: String, date: String) {
        let song = Music(context: self.managedObjectContext)
        
        song.name = name
        song.artist = artist
        song.album = album
        song.pictures = pictures
        song.text = text
        song.date = date
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
