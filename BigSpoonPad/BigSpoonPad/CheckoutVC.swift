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
        self.tapToEndLabel.addTarget(self, action: Selector("endBtnPressed:"), forControlEvents: UIControlEvents.TouchDown)
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
