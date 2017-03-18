//
//  ViewController.swift
//  Checklists
//
//  Created by Dmitry Cherkasov on 3/14/17.
//  Copyright © 2017 Dmitry Cherkasov. All rights reserved.
//
// swiftlint:disable force_cast
import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    //-----------
    required init?(coder aDecoder: NSCoder) {

        items = [Checklistitem]()

        let row0item = Checklistitem()
        row0item.text = "Read 50 pages"
        row0item.checked = false
        items.append(row0item)

        let row1item = Checklistitem()
        row1item.text = "Commit new features"
        row1item.checked = false
        items.append(row1item)

        let row2item = Checklistitem()
        row2item.text = "Look for job"
        row2item.checked = false
        items.append(row2item)

        let row3item = Checklistitem()
        row3item.text = "Read 50 pages"
        row3item.checked = false
        items.append(row3item)

        let row4item = Checklistitem()
        row4item.text = "Send CV's for vacanies from favorites list"
        row4item.checked = false
        items.append(row4item)

        super.init(coder: aDecoder)
    }
    //-----------

    //---------variables----------
    var items: [Checklistitem]
    //----------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//------------------------------------------------------------------------------

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        let item = items[indexPath.row]

        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

// MARK: prepare for segue---------------------------------------------------------

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self

            if let  indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

// MARK: some custom methods

    func configureCheckmark(for cell: UITableViewCell, with item: Checklistitem) {
        let label = cell.viewWithTag(1001) as! UILabel

        if item.checked {
            label.text = "√"
        } else {
            label.text = " "
        }
    }

    func configureText(for cell: UITableViewCell, with item: Checklistitem) {
        let label = cell.viewWithTag(1000) as! UILabel

        label.text = item.text
    }

// MARK: implementation ItemDetailViewController

    func itemDetailViewControllerDidCancel(_ conroller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: Checklistitem) {
        let newRowIndex = items.count
        items.append(item)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

        dismiss(animated: true, completion: nil)
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didiFinishEditing item: Checklistitem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
    }

}
