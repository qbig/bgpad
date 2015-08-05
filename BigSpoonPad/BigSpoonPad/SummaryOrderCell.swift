//
//  SummaryOrderCell.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 4/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class SummaryOrderCell: UITableViewCell {

    @IBOutlet weak var hiddenOptionsView: UIView!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var modLabel1: UILabel!
    @IBOutlet weak var modLabel2: UILabel!
    @IBOutlet weak var modLabel3: UILabel!
    @IBOutlet weak var modLabel4: UILabel!
    @IBOutlet weak var cancelBtnContainer: UIView!
    @IBOutlet weak var editBtnContainer: UIView!
    var labels:[UILabel]?
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        println("cancel pressed")
        NSNotificationCenter.defaultCenter().postNotificationName(BgConst.Key.NotifCancelOrderFromSummary, object: nil)
    }

    @IBAction func editBtnPressed(sender: AnyObject) {
        println("edit pressed")
        NSNotificationCenter.defaultCenter().postNotificationName(BgConst.Key.NotifEditOrderFromSummary, object: nil)
    }
    
    func hidModlabels() {
        if let myLabels = self.labels {
            for label in myLabels {
                label.hidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        self.labels = [modLabel1, modLabel2, modLabel3, modLabel4]
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
