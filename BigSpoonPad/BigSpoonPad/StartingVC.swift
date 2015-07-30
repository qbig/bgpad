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
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, "http://httpbin.org/get")
            .response { request, response, data, error in
                println(request)
                println(response)
                println(error)
                println("hahah")
        }
        let value = BGData.sharedDataContainer.someInt ?? 0
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        
        // add it to the image view;
        mainView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        mainView.userInteractionEnabled = true
    }
    
    func tapGesture(sender: AnyObject?) {
        performSegueWithIdentifier("startToMain", sender: sender);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
