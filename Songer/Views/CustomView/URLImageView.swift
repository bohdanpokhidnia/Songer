//
//  URLImageView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 21.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct URLImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    var width: CGFloat?
    var height: CGFloat?
    
    init(urlString: String, width: CGFloat = 50, height: CGFloat = 50) {
        urlImageModel = UrlImageModel(urlString: urlString)
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UIImage(named: "cover")!)
            .resizable()
            .frame(width: width ?? 50, height: height ?? 50)
    }
}

struct URLImageView_Previews: PreviewProvider {
    static let urlString = "https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/47/0c/02/470c024c-b39a-fa7c-f4e9-cc2a8c392638/source/350x350bb.jpg"
    
    static var previews: some View {
        URLImageView(urlString: urlString, width: 300, height: 300)
    }
}
