//
//  ButtonTableViewCellController.swift
//  ShoppingList
//
//  Created by Steve Cox on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ButtonTableViewCellController: UITableViewCell {
    
    var delegate: ButtonTableViewCellControllerDelegate?
    
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func completeButtonTapped(sender: AnyObject) {
        if let delegate = delegate {
            delegate.buttonCellButtonTapped(self)
        }
    }
    func updateButton(isComplete: Bool) {
        if isComplete {
        completeButton.setImage(UIImage(named:"complete"), forState: .Normal)
        } else {
        completeButton.setImage(UIImage(named:"incomplete"), forState: .Normal)
        }
    }
}

protocol ButtonTableViewCellControllerDelegate {
    func buttonCellButtonTapped(sender: ButtonTableViewCellController)
}

extension ButtonTableViewCellController {
    func updateWithItem(item: Item) {
        itemLabel.text = item.name
        updateButton(item.isComplete.boolValue)
    }
}