//
//  modelContainer.swift
//  StickyNotesNC1
//
//  Created by Claudio Marciello on 06/11/23.
//

import SwiftData
import Foundation


@Model
class Note: Identifiable{
    @Attribute(.unique) var id = UUID()
    var name: String
    var date: Date
    var color: String
    var font: String
    var fontColor: String
    var inFolderWith: [String] = []
    
    
    
    init(id: UUID, name: String, date: Date, color: String, font: String, fontColor: String) {
        self.id = id
        self.name = name
        self.date = date
        self.color = color
        self.font = font
        self.fontColor = fontColor
        
    }
}
