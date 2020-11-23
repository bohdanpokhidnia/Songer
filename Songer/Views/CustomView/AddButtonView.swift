//
//  ActionButtonView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 18.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct AddButtonView: View {
    
    @Binding var show: Bool
    var title: String
    var width: CGFloat?
    var height: CGFloat?
    var color = Color(UIColor.systemFill)
    
    var action: () -> ()
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 60)
//                .frame(width: show ? 0 : width ?? 80, height: height ?? 30)
//                .foregroundColor(color)
            
            Capsule()
                .frame(width: show ? 0 : width ?? 80, height: height ?? 30)
                .foregroundColor(color)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .opacity(show ? 0 : 1)
            
        }
        .animation(.default)
        .onTapGesture {
            self.show.toggle()
            self.action()
        }
    }
}


struct AddButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddButtonView(show: .constant(false), title: "Button", action: {})
            
    }
}
