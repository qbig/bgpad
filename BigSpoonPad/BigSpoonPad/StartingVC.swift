//
//  StartingVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 28/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import Alamofire

class StartingVC: UIViewController {

    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        mainView.addGestureRecognizer(tapGesture)
        mainView.userInteractionEnabled = true
    }
    
    func tapGesture(sender: AnyObject?) {
        performSegueWithIdentifier("startToMain", sender: sender);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
