//
//  SongView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct SongView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var song: Music
    
    @State private var showAlert: Bool = false
    @State private var showEditMusicView: Bool = false
    @State private var showSheets: Bool = false
    @State private var dateString: String = ""
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray)
                    .frame(width: 35, height: 5)
                    .opacity(0.5)
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 10) {
                    VStack {
                        Image(uiImage: UIImage(data: song.pictures) ?? UIImage(named: "cover")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 350)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .padding(.top, 20)
                            .padding(.horizontal)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(song.name)
                                    .font(.system(size: 20, weight: .semibold))
                                    .lineLimit(1)
                                    .onLongPressGesture {
                                        self.longPressToCopy(song.name)
                                    }
                                
                                Text(song.artist)
                                    .font(.system(size: 18, weight: .regular))
                                    .onLongPressGesture {
                                        self.longPressToCopy(song.artist)
                                    }
                                
                                Text(song.album)
                                    .font(.subheadline)
                                    .onLongPressGesture {
                                        self.longPressToCopy(song.album)
                                    }
                                
                                if let featArtistsLine = self.featArtistToOneLine(artists: self.song.featArtists) {
                                    Text(featArtistsLine)
                                        .font(.footnote)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                showSheets.toggle()
                            }, label: {
                                Image(systemName: "ellipsis.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            })
                        }
                        .frame(width: 350)
                    }
                    
                }.padding(.bottom, 10)
                
                Text(song.text)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .lineSpacing(5)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    .padding(.horizontal)
                
                Text(dateString)
                    .font(.caption)
                    .padding(.top, 10)
                
            }
            .sheet(isPresented: self.$showEditMusicView) {
                AddMusicView(song: self.song)
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Copy success"))
            }
            .actionSheet(isPresented: $showSheets) {
                ActionSheet(title: Text("Select action"),
                            buttons: [.default(Text("Edit music"), action: {
                                showEditMusicView.toggle()
                            }), .cancel()])
        }
            .onAppear {
                if let date = StringDateFormatter().formatStringDate(song.date, "dd.MM.yyyy", .long) {
                    self.dateString = date
                }
            }
       
    }
    
    func longPressToCopy(_ text: String) {
        PasteboardManager.setString(text: text)
        self.showAlert.toggle()
    }
    
    func featArtistToOneLine(artists: [String]?) -> String? {
        
        if let featArtists = artists {
            
            var result = "feat. "
            
            for artist in featArtists {
                
                if artist.isEmpty {
                    return nil
                }
                
                result += artist
            }
            
            return result
        } else {
            return nil
        }
        
    }
}

//struct SongView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        SongView(author: "Author")
//    }
//}
