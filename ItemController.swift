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
    
    static let sharedControlelr = ItemController()
    
    init() {
        let _ = NSFetchRequest(entityName: "Item")
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
        item.isComplete = item.isComplete.boolValue
        saveToPersistentStorage()
    }
    
}



