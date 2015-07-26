//
//  ViewController.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 25/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

