import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textView: UITextView!
    var note: Note?{
        didSet {
            // Configure cell appearance based on the note
            self.backgroundColor = UIColor(named: note!.color)
        }}
    var panGesture: UIPanGestureRecognizer!
    var originalCenter = CGPoint()
    var dragging = false
    
    func configureNote(note: Note) {
        self.note = note
        
        self.textView.text = note.name
        self.textView.textColor = note.fontColor
        self.textView.font = UIFont.systemFont(ofSize: CGFloat(note.fontSize))
        self.textView.isEditable = false
        
        
    }
   
}
