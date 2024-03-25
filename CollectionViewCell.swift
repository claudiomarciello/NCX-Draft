import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    var note: Note?{
        didSet {
            // Configure cell appearance based on the note
            self.backgroundColor = note?.color
        }}
    var panGesture: UIPanGestureRecognizer!
    var originalCenter = CGPoint()
    var dragging = false
    
    func configureNote(note: Note) {
        self.note = note
        self.label.text = note.name
        self.label.textColor = note.fontColor
    }
   
}
