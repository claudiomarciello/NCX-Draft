//
//  colorManagement.swift
//  StickyNotesNC1
//
//  Created by Claudio Marciello on 16/11/23.
//


import Foundation
import SwiftUI



extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }
    
    init(hexString: String, alpha: Double = 1.0) {
           var cleanedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
           cleanedString = cleanedString.replacingOccurrences(of: "#", with: "")

           var hex: UInt64 = 0
           Scanner(string: cleanedString).scanHexInt64(&hex)

           self.init(hex: UInt(hex), alpha: alpha)
       }
}
