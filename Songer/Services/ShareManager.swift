//
//  ShareManager.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 19.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

class ShareManager {
    
    static let share = ShareManager()
    
    private init() {}
    
    func shareUrl(url: String) {
        guard let data = URL(string: url) else { return }
        let activityView = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}
