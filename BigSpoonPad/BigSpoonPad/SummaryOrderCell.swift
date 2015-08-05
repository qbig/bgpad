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
    @IBOutlet weak var modInfoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
