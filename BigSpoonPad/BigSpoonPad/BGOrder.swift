//
//  BGOrder.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 2/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import SwiftyJSON
//            {
//                "product_uuid":2,
//                "qty": 1,
//                "modifiers":[
//                  {
//                      "uuid":"extra_noodles",
//                      "is_selected": true
//                  },
//                  {
//                      "uuid":"menu_set_side_1",
//                      "selected_radio_option_name": "Egg"
//                  }
//                ]
//            }

class BGOrder: NSObject {
    var productId:Int?
    var quantity: Int? = 1
    var modifiers: [Dictionary<String, String>]?
    
    func getParams() -> Dictionary<String, AnyObject>{
        var dict:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        dict["product_uuid"] = productId
        dict["qty"] = quantity
        dict["modifiers"] = modifiers
        return dict
    }
}
