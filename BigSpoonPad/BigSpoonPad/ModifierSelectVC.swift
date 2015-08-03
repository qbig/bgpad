//
//  ModifierSelectVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import Foundation

class ModifierSelectVC: UIViewController {
    var modifierCollectionsVC: ColorCollectionViewController!
    var currentItem: ItemModel?
    @IBOutlet weak var selectedItemLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = BGData.sharedDataContainer.currentOrder?.itemIndex {
            if let group = BGData.sharedDataContainer.currentOrder?.fromGroup {
                currentItem = BGData.sharedDataContainer.groupItems?[group].items?[item]
                self.selectedItemLabel.text = currentItem?.name
            }
        }
        nextButton.hidden = true;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("modSelectHandler:"), name: BgConst.Key.NotifModSelectChange, object: nil)
    }
    
    func modSelectHandler(notification: NSNotification) {
        println("mod change")
        modifierCollectionsVC = notification.object as! ColorCollectionViewController
        if (modifierCollectionsVC.isComplete()){
            nextButton.hidden = false
            BGData.sharedDataContainer.modifiers = modifierCollectionsVC.sectionModifiers as NSArray as? [ModifierSection]
        } else {
            nextButton.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func nextPressed() {
        self.performSegueWithIdentifier("ModToConfirm", sender: nil)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ModifierCollection" {
            modifierCollectionsVC = segue.destinationViewController as! ColorCollectionViewController
            for modSec in BGData.sharedDataContainer.modifiers! {
                modSec.unselect()
            }
            modifierCollectionsVC.sectionModifiers = NSMutableArray(array: BGData.sharedDataContainer.modifiers!)
        } else if segue.identifier == "ModToConfirm" {
            
        }
    }


}
