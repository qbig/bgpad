//
//  ConfirmOrderVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class ConfirmOrderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmBtnPressed() {
        self.performSegueWithIdentifier("ConfirmToCheckout", sender: nil)
    }

    @IBAction func addAnotherBtnPressed() {
    }
    
    @IBAction func cancelOrderBtnPressed(sender: AnyObject) {
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ConfirmToCheckout" {
            
        }
    }

}
