//
//  AddMusicArtistView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 26.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI
import CoreData

struct AddMusicView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingImagePicker: Bool = false
    @State private var showingAlert: Bool = false
    
    @State private var pictures: Image?
    @State private var inputImage: UIImage?
    
    @State private var name: String = "El Problema"
    @State private var artist: String = "Morgenshtern"
    @State private var album: String = ""
    @State private var text: String = ""
    @State private var featArtist: String = ""
    @State private var date: Date = Date()
    @State private var featArtists: [String] = []
    
    @State var navigationTitle: String = "Add music"
    @State var acceptButtonTitle: String = "Add"
    
    var song: Music?
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Information")) {
                    TextField("Name", text: self.$name)
                    TextField("Artist", text: self.$artist)
                    TextField("Album", text: self.$album)
                    TextField("Feat artist", text: self.$featArtist)
                }
                
                Section(header: Text("Automatic"), footer: Text("Input name and artist")) {
                    Button("Search") {
                        
                        if !name.isEmpty && !artist.isEmpty {
                            
                            ItunesDataFetcher().fetchTrackByArtist(artistName: artist, trackName: name) { (song) in
                                guard let song = song else { return }
                                
                                ItunesDataFetcher().fetchCoverFromUrl(url: song.artworkUrl350) { (image) in
                                    guard let image = image else { return }
                                    
                                    pictures = Image(uiImage: image)
                                    inputImage = image
                                    
                                }
                                
                                album = song.collectionName ?? song.trackName
                                
                                text = "Text song..."
                                
//                                print(song.stringDate)
                                
//                                print(StringDateFormatter().stringToDate("05.12.2000"))
                                
                                date = StringDateFormatter().stringToDate(song.stringDate, "yyyy.MM.dd")
                            }
                            
                        } else {
                            showingAlert.toggle()
                        }
                        
                    }
                }
                
                Section(header: Text("Date")) {
                    DatePicker("Release date", selection: $date, displayedComponents: .date)
                }
                
                Section(header: Text("Cover")) {
                    HStack {
                        Spacer()
                        
                        if let pictures = pictures {
                            CoverView(image: pictures)
                        } else {
                            CoverView(image: Image("cover"))
                        }
                        
                        Spacer()
                    }.onTapGesture {
                        self.showingImagePicker.toggle()
                    }
                }
                
                Section(header: Text("Text")) {
                    
                    if #available(iOS 14.0, *) {
                        TextEditor(text: self.$text)
                            .font(.subheadline)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 2000)
                    } else {
                        TextView(text: self.$text, placeholder: "Text song").frame(numLines: 10)
                    }
                }
            }
            .onAppear(perform: {
                self.edit()
            })
            .navigationBarTitle(Text(self.navigationTitle), displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel"){
                    self.presentationMode.wrappedValue.dismiss()
                },trailing: Button(self.acceptButtonTitle) {
                    if let song = self.song {
                        self.update(song: song)
                    } else {
                        if checkFields(){
                            self.addMusic()
                        } else {
                            self.showingAlert.toggle()
                        }
                    }
                })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Please, set fields"), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: self.$showingImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: self.$inputImage)
            })
        }
    }
    
    private func setFields(_ song: Music) {
        self.name = song.name
        self.artist = song.artist
        self.album = song.album
        if let featArtists = song.featArtists {
            self.featArtist = featArtists.first!
        }
        self.text = song.text
        self.pictures = Image(uiImage: UIImage(data: song.pictures)!)
        self.date = StringDateFormatter().stringToDate(song.date)
    }
    
    private func checkFields() -> Bool {
        if self.artist.isEmpty || self.album.isEmpty || self.name.isEmpty || self.text.isEmpty {
            return false
        }
        
        return true
    }
    
    private func addMusic() {
        
        var date = StringDateFormatter().dateToString(self.date)
        var pictures = UIImage(named: "cover")!.pngData()!
        
        if let inputImage = self.inputImage {
            pictures = inputImage.pngData()!
        }
        
        let databaseManager = DatabaseManager(managedObjectContext: self.managedObjectContext)
        
        databaseManager.addSong(name: self.name, artist: self.artist, album: self.album, pictures: pictures, text: self.text, date: date)
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func edit() {
        if let song = self.song {
            self.navigationTitle = "Edit music"
            self.acceptButtonTitle = "Save"
            
            self.setFields(song)
        }
    }
    
    private func update(song: Music) {
        
        if checkFields() {
            
            managedObjectContext.performAndWait {
                song.artist = self.artist
                song.album = self.album
                song.name = self.name
                
                if let newInputImage = self.inputImage {
                    song.pictures = newInputImage.pngData()!
                }
                
                song.featArtists = [self.featArtist]
                song.text = self.text
                song.date = StringDateFormatter().dateToString(self.date)
                
                try? managedObjectContext.save()
            }
            self.presentationMode.wrappedValue.dismiss()
        } else {
            self.showingAlert.toggle()
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        pictures = Image(uiImage: inputImage)
    }
    
    
}

struct AddMusicArtistView_Previews: PreviewProvider {
    
    @Environment(\.managedObjectContext) static var managedObjectContext
    
    static var previews: some View {
        AddMusicView().environment(\.managedObjectContext, managedObjectContext)
    }
}
