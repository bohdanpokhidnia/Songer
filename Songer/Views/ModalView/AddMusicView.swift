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
    
    @State private var name: String = "Дежавю"
    @State private var artist: String = "Артём Пивоваров"
    @State private var album: String = ""
    @State private var text: String = ""
    @State private var featArtist: String = ""
    @State private var date: Date = Date()
    @State private var featArtists: [String] = []
    @State private var previewUrl: String = "not found link"
    
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
                        
                        print("tap button")
                        
                        if !name.isEmpty && !artist.isEmpty {
                            
                            self.searchInfo()
                            
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
                                .animation(.default)
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
    
    private func searchInfo() {
        ItunesDataFetcher().fetchTrackByArtist(artistName: artist, trackName: name) { (song) in
            guard let song = song else { return }
            
            ItunesDataFetcher().fetchCoverFromUrl(url: song.artworkUrl350) { (image) in
                guard let image = image else { return }
                
                withAnimation {
                    pictures = Image(uiImage: image)
                }
                inputImage = image
            }
            
            previewUrl = song.trackViewUrl
            
            album = song.album
            
            MusicMatchDataFetcher().fetchTrackByNameAndArtist(artistName: self.artist, trackName: self.name) { (track) in
                if let track = track {
                    print(track.trackId)
                    print(track.artistName)
                    print(track.trackName)
                    
                    MusicMatchDataFetcher().fetchLyricsByTrackId(trackId: track.trackId) { (lyrics) in
                        guard let lyrics = lyrics else { return }
                        
                        self.text = lyrics
                    }
                }
            }
            
            date = StringDateFormatter().stringToDate(song.stringDate, "yyyy.MM.dd")
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
      
        let newSong = Music(context: self.managedObjectContext)
        
        let newDate = StringDateFormatter().dateToString(self.date)
        
        var pictures = UIImage(named: "cover")!.pngData()!
        
        if let inputImage = self.inputImage {
            pictures = inputImage.jpegData(compressionQuality: 1.0)!
        }
        
        newSong.artist = self.artist
        newSong.album = self.album
        newSong.name = self.name
        newSong.text = self.text
        newSong.previewUrl = self.previewUrl
        newSong.date = newDate
        newSong.pictures = pictures
        
        
        if !self.featArtist.isEmpty {
            newSong.featArtists = [self.featArtist]
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error when add song - \(error)")
        }
        
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
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print("error when update fields - \(error)")
                }
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
