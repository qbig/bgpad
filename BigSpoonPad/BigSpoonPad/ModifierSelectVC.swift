//
//  ModifierSelectVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class ModifierSelectVC: UIViewController {
    var modifierCollectionsVC: ColorCollectionViewController!
    @IBOutlet weak var selectedItemLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func nextPressed() {
        self.performSegueWithIdentifier("ModToConfirm", sender: nil)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ModifierCollection" {
            modifierCollectionsVC = segue.destinationViewController as! ColorCollectionViewController
            modifierCollectionsVC.sectionModifiers = NSMutableArray(array: BGData.sharedDataContainer.modifiers!)
        } else if segue.identifier == "ModToConfirm" {
            
        }
    }


}
