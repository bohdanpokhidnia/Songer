//
//  MusicArtist.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 24.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI
import CoreData

class MusicArtist: NSManagedObject, Identifiable {

    @NSManaged var name: String
    @NSManaged var pictures: Data

}
