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

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        mainView.addGestureRecognizer(tapGesture)
        mainView.userInteractionEnabled = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("newOrderReadyHandler"), name: BgConst.Key.NotifNewOrderCreated, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func startNewOrder () {
        let text = "Starting..."
        self.showWaitOverlayWithText(text)
        BGData.sharedDataContainer.createNewOrder()
        mainView.userInteractionEnabled = false
    }
    
    func tapGesture(sender: AnyObject?) {
        if (BGData.sharedDataContainer.newOrderCreated) {
            newOrderReadyHandler()
        } else {
            startNewOrder()
        }
    }
    
    func newOrderReadyHandler() {
        BGData.sharedDataContainer.newOrderCreated = true
        mainView.userInteractionEnabled = true
        self.removeAllOverlays()
        performSegueWithIdentifier("startToMain", sender: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
