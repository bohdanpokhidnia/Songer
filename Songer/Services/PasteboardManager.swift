//
//  PasteboardManager.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 19.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

class PasteboardManager {
    static let shared = PasteboardManager()
    
    private init() {}
    
    static func getString() -> String? {
        return UIPasteboard.general.string
    }
    
    static func setString(text: String) {
        UIPasteboard.general.string = text
    }
}
