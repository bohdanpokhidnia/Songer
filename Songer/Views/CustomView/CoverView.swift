//
//  CoverView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 20.09.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct CoverView: View {
    var image: Image
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        image
            .resizable()
            .renderingMode(.original)
            .frame(width: self.width ?? 150, height: self.height ?? 150)
            .shadow(radius: 5)
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView(image: Image("cover"))
    }
}
