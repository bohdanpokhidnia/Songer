//
//  UrlImageModel.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 19.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//
import SwiftUI

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String) {
        self.urlString = urlString
        
        loadImage()
    }
    
    func loadImage() {
        
        if !loadImageFromCache() {
            guard let urlString = self.urlString else { return }
            ItunesDataFetcher().fetchCoverFromUrl(url: urlString) { uiImage in
                
                guard let image = uiImage else { return }
                
                self.image = image
                self.imageCache.set(forKey: urlString, image: image)
            }
        }
        
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else { return false }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else { return false}
        
        image = cacheImage
        return true
    }
}
