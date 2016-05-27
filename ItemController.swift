//
//  ItemController.swift
//  ShoppingList
//
//  Created by Steve Cox on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    static let sharedController = ItemController()
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let request = NSFetchRequest(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key:"isComplete", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error Performing Data Fetch")
        }
    }

    
    func saveToPersistentStorage() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error Saving Data")
        }
    }
    
    func addItem(name: String){
        let _ = Item(name: name)
        saveToPersistentStorage()
    }

    func removeItem(item: Item){
        item.managedObjectContext?.deleteObject(item)
        saveToPersistentStorage()
    }
    
    func updateItem(item: Item, name: String){
        item.name = name
        saveToPersistentStorage()
    }
    
    func isCompleteToggled(item: Item){
        item.isComplete = !item.isComplete.boolValue
        saveToPersistentStorage()
    }
    
}