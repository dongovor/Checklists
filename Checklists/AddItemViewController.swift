//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Dmitry Cherkasov on 3/15/17.
//  Copyright © 2017 Dmitry Cherkasov. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ conroller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: Checklistitem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    weak var delegate: AddItemViewControllerDelegate?

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }

    @IBAction func done() {
        let item = Checklistitem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItemViewController(self, didFinishAdding: item)
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        textField.becomeFirstResponder()

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString

        doneBarButton.isEnabled = (newText.length > 0)

        return true
    }

}
