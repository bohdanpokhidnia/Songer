//
//  SongRow.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 05.09.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI
import UIKit

struct SongRow: View {
    
    var pictures: UIImage?
    var urlImage: String?
    var songName: String
    
    var author: String?
    
    var body: some View {
        HStack {
            
            if let cover = urlImage {
                
                URLImageView(urlString: cover)
                
            } else {
            
                Image(uiImage: pictures ?? UIImage(named: "cover")!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(songName)
                    .font(.body)
                
                if let author = author {
                    Spacer()
                    
                    Text(author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }.frame(height: 50)
            
            Spacer()
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    
    private static let image = UIImage(named: "cover")!
    private static let title = "Где нас нет"
    private static let author = "Oxxxymiron"
    
    static var previews: some View {
        
        SongRow(pictures: image, songName: title, author: author)
    }
}
