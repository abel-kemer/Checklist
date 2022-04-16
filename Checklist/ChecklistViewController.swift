//
//  ViewController.swift
//  Checklist
//
//  Created by Abel  on 12/04/2022.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var checklistDataSource: ChecklistDataSource = ChecklistDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init dummy checklist here
        checklistDataSource = ChecklistDataSource()
        checklistDataSource.initDummyChecklist()
    }
    
    //tableview asks how many rows are there in the data source?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistDataSource.getCount()
    }
    
    //tableview displays a cell for a specific row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "checklistitem",
            for: indexPath)
        
        let checklistItem = checklistDataSource.checkListItems[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
    
        label.text = checklistItem.title
        cell.accessoryType = checklistItem.checked == true ? .checkmark : .none
        
        return cell;
    }
    
    //let's handle click event for table view cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let selectedCell = tableView.cellForRow(at: indexPath){
            if selectedCell.accessoryType == .none{
                selectedCell.accessoryType = .checkmark
                checklistDataSource.checkListItems[indexPath.row].checked.toggle()
            }else{
                selectedCell.accessoryType = .none
                checklistDataSource.checkListItems[indexPath.row].checked.toggle()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //Add checklist item button action
    @IBAction func addChecklist(_ sender: UIBarButtonItem) {
        
        //newRowIndex
        let newRowIndex = checklistDataSource.getCount()
        
        //create new checklist item
        let checklistItem = ChecklistItem()
        
        checklistItem.title = "Checklist Item \(newRowIndex)"
        checklistItem.checked = false
        checklistDataSource.appendChecklistIem(at: checklistItem)
        
        //insertRow to tableView
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    //delete item from tableview
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
       
        //first remove data from our data source
        checklistDataSource.checkListItems.remove(at: indexPath.row)
        
        //then tell tableview to delete row at specified index
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    // MARK: - Table View Delegates
    override func tableView(
        _ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK: - Add Item ViewController Delegates
    func addItemViewControllerDidCancel(
        _ controller: AddChecklistItemViewController
    ) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(
        _ controller: AddChecklistItemViewController,
        didFinishAdding item: ChecklistItem
    ) {
        let newRowIndex = checklistDataSource.checkListItems.count
        checklistDataSource.checkListItems.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated:true)
    }
    // MARK: - Navigation
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddChecklistItemViewController
            controller.delegate = self
        }
    }
}




