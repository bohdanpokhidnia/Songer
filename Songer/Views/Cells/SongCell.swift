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
    @FetchRequest(entity: Music.entity(), sortDescriptors: []) var availableSongs: FetchedResults<Music>
    
    @State var isAddButtonShow: Bool = true
    @State var isShowButton = false
    
    var number: Int = 0
    var preview: UIImage?
    var urlImage: String?
    var songName: String
    var author: String?
    var trackPreviewUrl: String?
    var action: (() -> ())?
    
    var body: some View {
        HStack {
            Text("\(number)")
                .frame(width: 30)
            
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
                        .frame(maxWidth: .infinity)
                    
                    Text(author)
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
            
            Spacer()
            
            if isAddButtonShow {
                AddButtonView(show: $isShowButton, title: "Add") {
                    self.action?()
                }
            }
        }
        .contextMenu {
            Button(action: {
                if let url = trackPreviewUrl {
                    ShareManager.share.shareUrl(url: url)
                }
            }, label: {
                Text("Share")
                Image(systemName: "square.and.arrow.up")
            })
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .onAppear {
            availableSongs.forEach { song in
                if song.name == songName {
                    self.isAddButtonShow = false
                }
            }
        }
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

