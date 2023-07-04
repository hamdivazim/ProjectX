//
//  Extensions.swift
//  ProjectX
//
//  Created by Hamd Waseem on 01/06/2023.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var color: UInt64 = 0
        
        // Skip the '#' character
        scanner.scanLocation = 1
        
        // Parse hex value
        scanner.scanHexInt64(&color)
        
        // Extract RGB components
        let red = Double((color & 0xFF0000) >> 16) / 255.0
        let green = Double((color & 0x00FF00) >> 8) / 255.0
        let blue = Double(color & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
