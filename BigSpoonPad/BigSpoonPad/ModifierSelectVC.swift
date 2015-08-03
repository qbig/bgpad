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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("cancelCurrentOrderHandler"), name: BgConst.Key.NotifModalConfirmBtnPressed, object: nil)
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
    
    func cancelCurrentOrderHandler() {
        BGData.sharedDataContainer.currentOrder = BGOrder()
        if BGData.sharedDataContainer.currentOrders?.count > 0 {
            self.performSegueWithIdentifier("ModToConfirm", sender: nil)
        } else {
            self.navigationController?.popToViewController(self.navigationController?.viewControllers![1] as! UIViewController, animated: true)
        }
        
    }
    
    @IBAction func backPressed() {
        //self.navigationController?.popViewControllerAnimated(true)
        var settings = Modal.Settings()
        settings.backgroundColor = .whiteColor()
        settings.shadowType = .Hover
        settings.padding = CGFloat(30)
        settings.shadowRadius = CGFloat(5)
        settings.shadowOffset = CGSize(width: 0, height: 0)
        settings.shadowOpacity = 0.05
        settings.overlayBlurStyle = .Light
        let body = "Your current order is not complete. Leave this screen and discard your current order?"
        Modal(title: "", body: body, status: .Warning, settings: settings).show()
    }

    @IBAction func nextPressed() {
        // TODO: add current order to orders
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
