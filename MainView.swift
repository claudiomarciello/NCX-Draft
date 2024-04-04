
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
        
        if coordinator.session.localDragSession != nil {
            guard let sourceIndexPath = coordinator.items.first?.sourceIndexPath else { return }
            

            collectionView.performBatchUpdates {
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            } completion: { _ in
            }
            
            coordinator.drop(coordinator.items.first!.dragItem, toItemAt: destinationIndexPath)
            stickyNotes.swapAt(sourceIndexPath.item, destinationIndexPath.item)

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
        
        cell?.gestureRecognizers?.forEach { recognizer in
            cell?.removeGestureRecognizer(recognizer)
        }
        
        // Add the tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap(_:)))
        cell?.addGestureRecognizer(tapGesture)
        print(cell!.note!.color)
        cell!.layer.cornerRadius = 8
        cell!.layer.masksToBounds = true
        
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Perform necessary actions when a cell is tapped
        // For example, trigger the segue here
        print("selected")
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    
    @IBSegueAction func seguedes(_ coder: NSCoder) -> DetailView? {
        let Note = stickyNotes[collectionView.indexPathsForSelectedItems?.first?.row ?? 0]
        return DetailView(coder: coder, note: Note)
    }
    
    @objc func imageTapped() {
        stickyNotes.append(Note(id: UUID(), name: "New Note", date: Date(), color: "yellow", font: "regular", fontColor: UIColor(.black), fontSize: 18))
        print(stickyNotes.count)
        collectionView.reloadData()
        
        
    }
    
    @objc func segue() {
        
        performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
    let reuseIdentifier = "stickyNote"
    var stickyNotes = [Note]()
    @IBOutlet weak var Button: UIImageView!
    
    
    var selectedIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        Button.isUserInteractionEnabled = true // Enable user interaction
        
        let tapGesturePlus = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        Button.addGestureRecognizer(tapGesturePlus)
        let dropInteraction = UIDropInteraction(delegate: self)
        Button.addInteraction(dropInteraction)
        

        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self

        collectionView.dataSource = self
        collectionView.delegate = self
        

    }
    
    @objc func handleCellTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        guard let cell = gestureRecognizer.view as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        selectedIndexPath = indexPath
        
        // Perform necessary actions when a cell is tapped
        print("Selected cell at indexPath: \(indexPath)")
        performSegue(withIdentifier: "detailSegue", sender: self)
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
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing")
        if segue.identifier == "detailSegue" {
            print("preparing")
            
            // Check if the destination view controller is DetailView
            if let destination = segue.destination as? DetailView {
                print("preparing")
                
                
                let selectedNote = stickyNotes[selectedIndexPath!.row]
                // Pass the selected note to the destination view controller
                destination.note = selectedNote
                print("passed note \(selectedNote.name)")
                print(selectedNote.color)
            }
            
            
        }
    }
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, sender: Any?) -> Bool {
        true
    }
    @IBAction func unwindToViewControllerWithSegue(segue: UIStoryboardSegue) {
        print("unwindToViewControllerWithSegue called")
        if segue.identifier == "backSegue" {
            print("backSegue identified")
            if let sourceViewController = segue.source as? DetailView {
                print("sourceViewController: \(sourceViewController)")
                if let note = sourceViewController.note {
                    print("note: \(note)")
                    if let selectedIndexPath = selectedIndexPath {
                        print("selectedIndexPath: \(selectedIndexPath)")
                        stickyNotes[selectedIndexPath.row] = note
                        print(stickyNotes[selectedIndexPath.row].name)
                        collectionView.reloadItems(at: [selectedIndexPath])
                        collectionView.reloadData()

                        print("Note updated and collection view reloaded")

                    } else {
                        print("No selected index path")
                    }
                } else {
                    print("Note is nil")
                }
            } else {
                print("Failed to cast source view controller to DetailView")
            }
        } else {
            print("Segue identifier does not match")
        }
    }


    
    
}
