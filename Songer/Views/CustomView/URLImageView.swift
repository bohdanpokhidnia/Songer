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
    @State var image: UIImage = UIImage(named: "cover")!
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 50, height: 50)
            .onAppear {
                ItunesService().fetchURLImage(urlString: self.urlString) { (uiimage) in
                    self.image = uiimage
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
