//
//  MainGroupSelectVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 28/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class MainGroupSelectVC: UIViewController {
    @IBOutlet weak var groupSelectScrollView: UIScrollView!
    @IBOutlet weak var firstItem: UIImageView!
    @IBOutlet weak var lastItem: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func backPressed() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }


    @IBOutlet weak var scrollBackButton: UIButton!
    
    @IBAction func scrollBackPressed() {
        groupSelectScrollView.scrollRectToVisible(firstItem.frame, animated: true)
    }
    
    @IBOutlet weak var scrollNextButton: UIButton!
    
    @IBAction func scrollNextPressed() {
        groupSelectScrollView.scrollRectToVisible(lastItem.frame, animated: true)
    }
    
    @IBAction func groupSelected(sender: AnyObject) {
        println("selected")
    }
}
