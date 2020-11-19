//
//  Song.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//


import SwiftUI
import CoreData

class Music: NSManagedObject, Identifiable {
    
    @NSManaged public var name: String
    @NSManaged public var artist: String
    @NSManaged public var album: String
    @NSManaged public var featArtists: [String]?
    @NSManaged public var pictures: Data
    @NSManaged public var text: String
    @NSManaged public var date: String
    
}
