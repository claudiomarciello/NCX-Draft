//
//  CollectionViewCell.swift
//  StickyNotesNC1
//
//  Created by Claudio Marciello on 23/03/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var note: Note?
    func configureNote(note: Note){
        self.note = note
        
    }
}
