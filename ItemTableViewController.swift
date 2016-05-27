//
//  ItemTableViewController.swift
//  ShoppingList
//
//  Created by Steve Cox on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class ItemTableViewController: UITableViewController, ButtonTableViewCellControllerDelegate, NSFetchedResultsControllerDelegate
{
    var item: Item?
    
    override func viewDidLoad() {
        self.title = "Shopping List"
        ItemController.sharedController.fetchedResultsController.delegate = self
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ItemController.sharedController.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = ItemController.sharedController.fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as? ButtonTableViewCellController,
            let item = ItemController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {
                return ButtonTableViewCellController()
        }
        
        cell.updateWithItem(item)
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let item = ItemController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else { return }
            ItemController.sharedController.removeItem(item)
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = ItemController.sharedController.fetchedResultsController.sections, index = Int(sections[section].name) else {
            return nil
        }
        if index == 0 {
            return "Need"
        } else {
            return "Already Got"
        }
    }
    
    func addItemAlert() {
        
        let alertController = UIAlertController(title:"add to Shopping List", message: "what do you need from the store?", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler {(alertTextField) in alertTextField.placeholder = "enter item"
            self.alertTextField = alertTextField
        }
        
        let addItemAction = UIAlertAction(title: "Add to List", style: .Default) { (_) in
            guard let name = self.alertTextField.text else {
                return
            }
            ItemController.sharedController.addItem(name)
            // I probably need to add something here-ish that disables adding blank/empty strings to list
        }
        
        let cancelAction = UIAlertAction(title: "Nevermind", style: .Default, handler: nil)
        
        alertController.addAction(addItemAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        addItemAlert()
    }
    
    @IBOutlet var alertTextField: UITextField!
    
    func updateItem() {
        guard let name = alertTextField.text else {
            return
        }
        if let item = self.item {
            ItemController.sharedController.updateItem(item, name : name)
        } else {
            ItemController.sharedController.addItem(name)
        }
    }
    
    func updateWithItem(item: Item) {
        self.item = item
        alertTextField.text = item.name
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anyObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            
        case .Delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else { return }
            tableView.moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
            
        case .Update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
            
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
            
        case .Move:
            break
            
        case .Update:
            break
            
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    func buttonCellButtonTapped(sender: ButtonTableViewCellController) {
        guard let indexPath = tableView.indexPathForCell(sender),
            item = ItemController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {return}
        ItemController.sharedController.isCompleteToggled(item)
    }
    
}
