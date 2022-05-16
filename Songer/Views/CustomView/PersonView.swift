//
//  PersonView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 20.09.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct PersonView: View {
    var image: Image
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        image
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
            .frame(width: self.width ?? 275, height: self.height ?? 275)
    }
}

struct PersonView_Previews: PreviewProvider {
    private static let image = Image("person")
    
    static var previews: some View {
        PersonView(image: image)
    }
}
