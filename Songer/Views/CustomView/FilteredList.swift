//
//  FilteredList.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 24.09.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let content: (T) -> Content
    var fetchRequest: FetchRequest<T>
    var songs: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    init(filteredKey: String, filteredValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filteredKey, filteredValue))
        self.content = content
        
        if filteredValue.isEmpty {
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [])
        }
    }
    
    var body: some View {
        List {
            ForEach(fetchRequest.wrappedValue, id: \.self) { song in
                self.content(song)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(index: IndexSet) {
        guard let firstIndex = index.first else { return }
        let deleteArtist = songs[firstIndex]
        self.managedObjectContext.delete(deleteArtist)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("[dev] Error in remove object from DB: ", error)
        }
    }
}
