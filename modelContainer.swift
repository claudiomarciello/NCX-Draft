//
//  modelContainer.swift
//  StickyNotesNC1
//
//  Created by Claudio Marciello on 06/11/23.
//

import SwiftData
import Foundation
import UIKit

class Note: Identifiable{
    var id = UUID()
    var name: String
    var date: Date
    var color: UIColor
    var font: String
    var fontColor: UIColor
    var inFolderWith: [String] = []
    
    
    
    init(id: UUID, name: String, date: Date, color: UIColor, font: String, fontColor: UIColor) {
        self.id = id
        self.name = name
        self.date = date
        self.color = color
        self.font = font
        self.fontColor = fontColor
        
    }
}
