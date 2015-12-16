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
    var sideSummaryVC : SideSummaryVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("orderCompleteHandler:"), name: BgConst.Key.NotifOrderItemsAdded, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("cancelCurrentOrderHandler"), name: BgConst.Key.NotifModalConfirmBtnPressed, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        sideSummaryVC?.tableView.reloadData()
    }
    
    func cancelCurrentOrderHandler() {
        BGData.sharedDataContainer.newOrderCreated = false
        self.navigationController?.popToRootViewControllerAnimated(true)
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
        BGData.sharedDataContainer.currentOrder = BGOrder()
        self.navigationController?.popToViewController(self.navigationController?.viewControllers[1] as UIViewController!, animated: true)
    }
    
    @IBAction func cancelOrderBtnPressed(sender: AnyObject) {
        var settings = Modal.Settings()
        settings.backgroundColor = .whiteColor()
        settings.shadowType = .Hover
        settings.padding = CGFloat(30)
        settings.shadowRadius = CGFloat(5)
        settings.shadowOffset = CGSize(width: 0, height: 0)
        settings.shadowOpacity = 0.05
        settings.overlayBlurStyle = .Light
        settings.confirmText = "Okay"
        settings.dismissText = "Dismiss"
        let body = "Your current order is not complete. Leave this screen and discard your current order?"
        Modal(title: "", body: body, status: .Warning, settings: settings).show()

    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ConfirmToCheckout" {
            
        } else if segue.identifier == "SideInConfirm" {
            
        }
    }

}
