//
//  AddArtistView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 03.09.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI
import UIKit
import CoreData

struct AddArtistView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    
    @State private var name: String = ""
    @State private var pictures: Image?
    
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Artist name")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Pictures")) {
                    HStack {
                        Spacer()
                        
                        if let pictures = pictures {
                            PersonView(image: pictures)
                        } else {
                            PersonView(image: Image("person"))
                        }
                        
                        Spacer()
                    }.onTapGesture {
                        self.showingImagePicker.toggle()
                    }
                }
                
            }
            .navigationBarTitle("Add artist", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel"){
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                
                self.addArtist()
                
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: self.$inputImage)
            })
        }
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        pictures = Image(uiImage: inputImage)
    }
    
    func addArtist() {
        let databaseManager = DatabaseManager(managedObjectContext: self.managedObjectContext)
        
        databaseManager.addArtist(artistName: self.name, artistPictures: self.inputImage!.pngData()!)
    }
}

struct AddArtistView_Previews: PreviewProvider {
    
    @Environment(\.managedObjectContext) static var managedObjectContext
    
    static var previews: some View {
        
        AddArtistView().environment(\.managedObjectContext, managedObjectContext)
    }
}
