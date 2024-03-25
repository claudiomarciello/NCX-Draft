//
//  DetailView.swift
//
//  Created by Claudio Marciello on 23/03/24.
//

import UIKit

class DetailView: UIViewController, UITextFieldDelegate {

    var note: Note?
    @IBOutlet weak var noteView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var fontButton: UIButton!

    @IBOutlet weak var Save: UIBarButtonItem!
    required init?(coder: NSCoder, note: Note?) {
        self.note = note
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = note?.name
        textField.textColor = note?.fontColor
        noteView.backgroundColor = note?.color
        // Do any additional setup after loading the view.
        textField.backgroundColor = note?.color
        

    }
    
    @IBOutlet weak var backButton: UINavigationItem!
    
    
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, sender: Any?) -> Bool {
        true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        note?.name = textField.text!
        guard segue.identifier == "backSegue" else { return }

    }
    override func didMove(toParent parent: UIViewController?) {
        if !(parent?.isEqual(self.parent) ?? false) {
            print("Parent view loaded")
        }
        super.didMove(toParent: parent)
    }
    
   

}
