//
//  SearchBarView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 23.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String?
    var action: () -> ()
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        var action: () -> ()
        
        init(text: Binding<String>, action: @escaping () -> ()) {
            _text = text
            self.action = action
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.action()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, action: action)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = placeholder ?? ""
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}
