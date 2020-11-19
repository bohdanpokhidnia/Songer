//
//  SongRow.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 05.09.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI
import UIKit

struct SongCell: View {
    
    var isAddButtonShow: Bool?
    var preview: UIImage?
    var urlImage: String?
    var songName: String
    var author: String?
    var action: () -> ()
    
    @State var isShowButton = false
    
    var body: some View {
        HStack {
            
            if let cover = urlImage {
                
                URLImageView(urlString: cover)
                
            } else {
                Image(uiImage: preview ?? UIImage(named: "cover")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
            
            if isAddButtonShow != nil {
                AddButtonView(show: $isShowButton, title: "Add") {
                    self.action()
                }
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
}

struct SongRow_Previews: PreviewProvider {
    
    private static let image = UIImage(named: "cover")!.pngData()!
    private static let title = "Где нас нет"
    private static let author = "Oxxxymiron"
    
    static var previews: some View {
        
        SongCell(isAddButtonShow: true,
                songName: title,
                author: author, action: {})
    }
}

