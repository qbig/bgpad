//
//  GroupItemSelectVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 28/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class GroupItemSelectVC: UIViewController, TabCollectionProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    var tabsController: GroupTabCollectionVC!
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TabsContained" {
            tabsController = segue.destinationViewController as! GroupTabCollectionVC
            tabsController.delegate = self
        }
    }
    
    func tabSelected(controller:GroupTabCollectionVC, cellSelcted:GroupTabCollectionViewCell) {
        // TODO: update items select collection view
    }

}
