//
//  ItemTableViewController.swift
//  ShoppingList
//
//  Created by Steve Cox on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController, ButtonTableViewCellControllerDelegate {

    
    var item: Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = ItemController.sharedController.fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath)

        return cell
    }
 
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    }
    
    
    
    @IBAction func addButtonTapped(sender: AnyObject) {
    }
    
    
    @IBOutlet var alertTextField: UITextField!
    
    
    
    
    
    
}
