//
//  StartingVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 28/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftOverlays

class StartingVC: UIViewController {

    @IBOutlet var mainView: UIView!
    var newOrderCreated = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        mainView.addGestureRecognizer(tapGesture)
        mainView.userInteractionEnabled = true
    }
    
    func startNewOrder () {
        let text = "Starting..."
        self.showWaitOverlayWithText(text)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("newOrderReadyHandler"), name: BgConst.Key.NotifNewOrderCreated, object: nil)
        BGData.sharedDataContainer.createNewOrder()
        mainView.userInteractionEnabled = false
    }
    
    func tapGesture(sender: AnyObject?) {
        if (newOrderCreated) {
            newOrderReadyHandler()
        } else {
            startNewOrder()
        }
    }
    
    func newOrderReadyHandler() {
        newOrderCreated = true
        mainView.userInteractionEnabled = true
        self.removeAllOverlays()
        performSegueWithIdentifier("startToMain", sender: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
