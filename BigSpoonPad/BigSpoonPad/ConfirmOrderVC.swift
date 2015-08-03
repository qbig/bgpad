//
//  ConfirmOrderVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import SwiftOverlays

class ConfirmOrderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("orderCompleteHandler:"), name: BgConst.Key.NotifOrderItemsAdded, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmBtnPressed() {
        let text = "Sending..."
        self.showWaitOverlayWithText(text)
        BGData.sharedDataContainer.completeOrder()
    }
    
    func orderCompleteHandler(notification: NSNotification) {
        self.removeAllOverlays()
        BGData.sharedDataContainer.newOrderCreated = false
        self.performSegueWithIdentifier("ConfirmToCheckout", sender: nil)
    }

    @IBAction func addAnotherBtnPressed() {
        self.navigationController?.popToViewController(self.navigationController?.viewControllers![1] as! UIViewController, animated: true)
    }
    
    @IBAction func cancelOrderBtnPressed(sender: AnyObject) {
        
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ConfirmToCheckout" {
            
        }
    }

}
