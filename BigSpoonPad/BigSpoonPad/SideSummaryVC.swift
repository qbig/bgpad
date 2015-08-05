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
    
    let showsArray = ["House of Cards","Arrested Development","Orange is the New Black","Unbreakable","Daredevil","The Killing","BoJack Horseman","Mad Men","Breaking Bad","Bates Motel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.dataSource = self
        tableView.delegate = self
        updateUI()
    }
    
    func updateUI() {
        if BGData.sharedDataContainer.currentOrder?.itemIndex != nil && BGData.sharedDataContainer.currentOrders?.count != 0{
            self.backgroundImageView.image = UIImage(named: activeImageName)
            self.topLabel.hidden = false
            var tableFrame:CGRect = self.tableView.frame
            tableFrame.size.height = 566
            self.tableView.frame = tableFrame
            self.tableView.hidden = false
            self.bottomTotalView.hidden = false
            self.bottomTotalViewUnder.hidden = true
            self.headToCheckoutBtn.hidden = false
        } else  if BGData.sharedDataContainer.currentOrder?.itemIndex == nil  && BGData.sharedDataContainer.currentOrders?.count == 0{
            self.backgroundImageView.image = UIImage(named: inactiveImageName)
            var tableFrame:CGRect = self.tableView.frame
            tableFrame.size.height = 566 + 98 + 50
            self.tableView.frame = tableFrame
            self.tableView.hidden = true
            self.topLabel.hidden = true
            self.bottomTotalView.hidden = true
            self.bottomTotalViewUnder.hidden = true
            self.headToCheckoutBtn.hidden = true
        } else if BGData.sharedDataContainer.currentOrders?.count == 0 {
            self.backgroundImageView.image = UIImage(named: activeImageName)
            var tableFrame:CGRect = self.tableView.frame
            tableFrame.size.height = 566 + 98
            self.tableView.frame = tableFrame
            self.tableView.hidden = false
            self.topLabel.hidden = false
            self.bottomTotalView.hidden = true
            self.bottomTotalViewUnder.hidden = false
            var bottomFrame:CGRect = self.bottomTotalView.frame
            bottomFrame.origin.y = CGFloat(670)
            
            UIView.animateWithDuration(0.3,
                delay: 0,
                options: .CurveEaseInOut ,
                animations: {
            self.bottomTotalView.frame = bottomFrame
                },
                completion: { finished in
                    println("Bug moved left!")
                    
            })

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
        return showsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let retCell = tableView.dequeueReusableCellWithIdentifier("SummaryOrderCell") as! SummaryOrderCell
        
        retCell.orderNameLabel.text = self.showsArray[indexPath.row]
        
        return retCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 130.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let myCell = tableView.cellForRowAtIndexPath(indexPath) as! SummaryOrderCell
        
        UIView.animateWithDuration(0.3,
            delay: 0,
            options: .CurveEaseInOut ,
            animations: {
                var frame = myCell.hiddenOptionsView.frame
                frame.origin.x = 0
                myCell.hiddenOptionsView.frame = frame
            },
            completion: { finished in
                println("Bug moved left!")
                
        })
    }
}
