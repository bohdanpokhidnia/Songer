//
//  ArtistView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 24.08.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct ArtistRow: View {
    
    var artistName: String = ""
    var artistPictures: UIImage = UIImage(named: "cover")!
    
    var body: some View {
        HStack {
            Image(uiImage: artistPictures)
                .resizable()
//                .renderingMode(.original)
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 0.3))
            
            Text(artistName)
            
            Spacer()
        }
        
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistRow(artistName: "Artist", artistPictures: UIImage(named: "person")!)
    }
}
