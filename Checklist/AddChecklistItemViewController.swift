//
//  AddChecklistItemViewController.swift
//  Checklist
//
//  Created by Abel  on 15/04/2022.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func addItemViewControllerDidCancel(
        _ controller: AddChecklistItemViewController)
    func addItemViewController(
        _ controller: AddChecklistItemViewController,
        didFinishAdding item: ChecklistItem
    )
}

class AddChecklistItemViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var delegate: AddItemViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: Any) {
        let item = ChecklistItem()
        item.title = textField.text!
        navigationController?.popViewController(animated: true)
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
}

// MARK: - Text Field Delegates
func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
) -> Bool {
    
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    _ = oldText.replacingCharacters(
        in: stringRange,
        with: string)

    return true
}
