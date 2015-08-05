//
//  SideSummaryVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 4/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class SideSummaryVC: UIViewController,  UITableViewDataSource, UITableViewDelegate  {
    let inactiveImageName = "yellow-right-border.png"
    let activeImageName = "bg-order-summary.png"
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headToCheckoutBtn: UIButton!
    @IBOutlet weak var bottomTotalView: UIView!
    @IBOutlet weak var buttonTotalLabel: UILabel!
    @IBOutlet weak var bottomTotalViewUnder: UIView!
    @IBOutlet weak var bottomTotalViewUnderLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.dataSource = self
        tableView.delegate = self

        updateUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("cleanCell"), name: BgConst.Key.NotifCancelOrderFromSummary, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("cleanCell"), name: BgConst.Key.NotifEditOrderFromSummary, object: nil)
    }
    
    func cleanCell() {
        tableView.reloadData()
    }
    
    func setLabel(totalPrice: Double) {
        self.buttonTotalLabel.text = "$\(totalPrice)"
        self.bottomTotalViewUnderLabel.text = "$\(totalPrice)"
    }
    
    func updateUI() {
        if BGData.sharedDataContainer.currentOrders?.count != 0{
            self.backgroundImageView.image = UIImage(named: activeImageName)
            self.topLabel.hidden = false
            var tableFrame:CGRect = self.tableView.frame
            tableFrame.size.height = 566
            self.tableView.frame = tableFrame
            self.tableView.hidden = false
            self.bottomTotalView.hidden = false
            self.bottomTotalViewUnder.hidden = true
            self.headToCheckoutBtn.hidden = false
        } else  if BGData.sharedDataContainer.currentOrder?.itemIndex == nil {
            self.backgroundImageView.image = UIImage(named: inactiveImageName)
            var tableFrame:CGRect = self.tableView.frame
            tableFrame.size.height = 566 + 98 + 50
            self.tableView.frame = tableFrame
            self.tableView.hidden = true
            self.topLabel.hidden = true
            self.bottomTotalView.hidden = true
            self.bottomTotalViewUnder.hidden = true
            self.headToCheckoutBtn.hidden = true
        } else {
            self.backgroundImageView.image = UIImage(named: activeImageName)
            var tableFrame:CGRect = self.tableView.frame
            tableFrame.size.height = 566 + 98
            self.tableView.frame = tableFrame
            self.tableView.hidden = false
            self.topLabel.hidden = false
            self.bottomTotalView.hidden = true
            self.bottomTotalViewUnder.hidden = false
            self.headToCheckoutBtn.hidden = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func headToCheckoutPressed(sender: AnyObject) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UITableView Protocol 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var cnt = 0
        if let doneOrder = BGData.sharedDataContainer.currentOrders?.count  {
            cnt += doneOrder
        }
        
        if BGData.sharedDataContainer.currentOrder?.itemIndex != nil {
            cnt += 1
        }
        
        return cnt
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let retCell = tableView.dequeueReusableCellWithIdentifier("SummaryOrderCell") as! SummaryOrderCell
        var frame = retCell.hiddenOptionsView.frame
        if (retCell.selected) {
            frame.origin.x = 296 - 130
        } else {
            frame.origin.x = 296
        }
        
        retCell.hiddenOptionsView.frame = frame
        if BGData.sharedDataContainer.currentOrder?.itemIndex != nil {
            if indexPath.row == 0 {
                if let currentOrder = BGData.sharedDataContainer.currentOrder {
                    retCell.orderNameLabel.text = currentOrder.productName
                    retCell.itemPriceLabel.text = "$\(currentOrder.productPriceFinal!/100)"
                    retCell.hidModlabels()
                    if let modAns = currentOrder.modifierAns {
                        for (index: Int, modOption:String) in enumerate(modAns){
                            retCell.labels?[index].hidden = false
                            retCell.labels?[index].text = "- \(modOption)"
                        }
                    }
                }
                
            } else {
                if let currentOrder = BGData.sharedDataContainer.currentOrders?[indexPath.item - 1] {
                    retCell.orderNameLabel.text = currentOrder.productName
                    retCell.itemPriceLabel.text = "$\(currentOrder.productPriceFinal!/100)"
                    retCell.hidModlabels()
                    if let modAns = currentOrder.modifierAns {
                        for (index: Int, modOption:String) in enumerate(modAns){
                            retCell.labels?[index].hidden = false
                            retCell.labels?[index].text = "- \(modOption)"
                        }
                    }
                }
            }
 
        } else {
            if let currentOrder = BGData.sharedDataContainer.currentOrders?[indexPath.item] {
                retCell.orderNameLabel.text = currentOrder.productName
                retCell.itemPriceLabel.text = "$\(currentOrder.productPriceFinal!/100)"
                retCell.hidModlabels()
                if let modAns = currentOrder.modifierAns {
                    for (index: Int, modOption:String) in enumerate(modAns){
                        retCell.labels?[index].hidden = false
                        retCell.labels?[index].text = "- \(modOption)"
                    }
                }
            }
        }
        
        return retCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 130.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let myCell = tableView.cellForRowAtIndexPath(indexPath) as! SummaryOrderCell
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if (myCell.hiddenOptionsView.frame.origin.x != 296) {
            self.tableView.reloadData()
        }
        
        UIView.animateWithDuration(0.2,
            delay: 0,
            options: .CurveEaseInOut ,
            animations: {
                var frame = myCell.hiddenOptionsView.frame
                frame.origin.x = 296 - 130
                myCell.hiddenOptionsView.frame = frame
            },
            completion: { finished in
                
        })
    }
}
