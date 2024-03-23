
//  ViewController.swift
//  StickyNotesNC1
//
//  Created by Claudio Marciello on 22/03/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UIDropInteractionDelegate{
    var dragIndex: IndexPath = IndexPath(item: 0, section: 0)
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
           let itemProvider = NSItemProvider(object: NSString(string: "StickyNote"))
           let dragItem = UIDragItem(itemProvider: itemProvider)
        dragIndex = indexPath

           return [dragItem]
       }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
            let destinationIndexPath: IndexPath
            if let indexPath = coordinator.destinationIndexPath {
                destinationIndexPath = indexPath
            } else {
                // Calculate destination index path if it's not provided
                let section = collectionView.numberOfSections - 1
                let row = collectionView.numberOfItems(inSection: section)
                destinationIndexPath = IndexPath(row: row, section: section)
            }
            
            // Check if the drop is from the same collection view
            if coordinator.session.localDragSession != nil {
                // Get the original index path of the item being dragged
                guard let sourceIndexPath = coordinator.items.first?.sourceIndexPath else { return }
                
                // Update your data source to reflect the swap
                let movedNote = stickyNotes.remove(at: sourceIndexPath.item)
                stickyNotes.insert(movedNote, at: destinationIndexPath.item)
                
                
                // Perform the interactive move in the collection view
                collectionView.performBatchUpdates {
                    collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
                } completion: { _ in
                }
                
                coordinator.drop(coordinator.items.first!.dragItem, toItemAt: destinationIndexPath)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
            if collectionView.hasActiveDrag {
                
                if session.localDragSession != nil {
                    return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
                }
                
            }
        else
        {
}
        
            return UICollectionViewDropProposal(operation: .cancel)
        }
        


    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickyNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stickyNote", for: indexPath) as? CollectionViewCell
        cell?.configureNote(note: stickyNotes[indexPath.row])
        cell?.backgroundColor = cell?.note?.color
 

        print(cell!.note!.color)

        
        return cell!
    }

    

    @objc func imageTapped() {
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "white"))
        print(stickyNotes.count)
        collectionView.reloadData()
        
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let reuseIdentifier = "stickyNote"
    var stickyNotes = [Note]()
    @IBOutlet weak var Button: UIImageView!

  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

           Button.isUserInteractionEnabled = true // Enable user interaction
           
           // Add tap gesture recognizer
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
           Button.addGestureRecognizer(tapGesture)

        let dropInteraction = UIDropInteraction(delegate: self)
                Button.addInteraction(dropInteraction)
        

        // Enable reordering of cells
              collectionView.dragInteractionEnabled = true
              collectionView.dragDelegate = self
              collectionView.dropDelegate = self
        
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.green), font: "regular", fontColor: "black"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.blue), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        stickyNotes.append(Note(id: UUID(), name: "sex", date: Date(), color: UIColor(.yellow), font: "regular", fontColor: "White"))
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }


    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        // Allow handling any type of drop session
        return true
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        // Propose to copy the item when dropping onto the button
        
        return UIDropProposal(operation: .move)
    }
    
        
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        // Perform actions when the drag session enters the view
        UIView.transition(with: Button, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.Button.tintColor = .red
            self.Button.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: nil)
        print("Drag session entered the view")
    }
    
    func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
        Button.tintColor = .gray
        Button.image = UIImage(systemName: "trash.circle")
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        Button.tintColor = .green
        self.Button.transform = .identity
        Button.image = UIImage(systemName: "plus.circle")

    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        // Perform actions when the drag session exits the view

        Button.tintColor = .gray
        self.Button.transform = .identity
        print("Drag session exited the view")
        
    }
    
       func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
           // Perform actions when the drop occurs

               // If the drop contains items of type "StickyNote"
               let location = session.location(in: view)

               // Check if the drop occurred on the button
               if Button.frame.contains(location) {
                   // Perform actions specific to dropping on the button
                   print("Item dropped on the button!")
                   
                               // Remove the corresponding element from the stickyNotes array
                               stickyNotes.remove(at: dragIndex.item)
                               
                               // Update the collection view to reflect the removal of the item
                   collectionView.reloadData()
                           }

                      }
       
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
