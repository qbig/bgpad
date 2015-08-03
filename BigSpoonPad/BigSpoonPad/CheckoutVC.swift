//
//  CheckoutVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController {
    @IBOutlet weak var queueNumLabel: UILabel!
    @IBOutlet weak var tapToEndLabel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        var uuid = BGData.sharedDataContainer.currentOrderJson!["uuid"].stringValue
        var index1 = advance(uuid.endIndex, -3)
        var substringFromUuid = uuid.substringFromIndex(index1)
        self.queueNumLabel.text? = substringFromUuid
        self.tapToEndLabel.addTarget(self, action: Selector("endBtnPressed:"), forControlEvents: UIControlEvents.TouchDown)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let seconds = 10.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.navigationController?.popToRootViewControllerAnimated(animated)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endBtnPressed(sender: AnyObject) {
        println("End pressed")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
