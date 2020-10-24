//
//  URLImageView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 21.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct URLImageView: View {
    var urlString: String
    @State var cover: UIImage = UIImage(named: "cover")!
    
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        Image(uiImage: cover)
            .resizable()
            .frame(width: width ?? 50, height: height ?? 50)
            .onAppear {
                ItunesDataFetcher().fetchCoverFromUrl(url: urlString) { (image) in
                    guard let image = image else { return }
                    
                    cover = image
                }
            }
    }
}

struct URLImageView_Previews: PreviewProvider {
    
    static let urlString = "https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/47/0c/02/470c024c-b39a-fa7c-f4e9-cc2a8c392638/source/350x350bb.jpg"
    
    static var previews: some View {
        URLImageView(urlString: urlString)
    }
}
