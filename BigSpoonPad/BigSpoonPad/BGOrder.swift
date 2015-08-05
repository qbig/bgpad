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
    var productName: String?
    var productPrice: Double?
    var productPriceFinal: Double?
    var quantity: Int? = 1
    var fromGroup: Int?
    var modifierAns: [String]?
    var modChoices : [Int]? {
        didSet {
            modifiers = [Dictionary<String, String>]()
            modifierAns = [String]()
            productPriceFinal = productPrice
            for (index, choice) in enumerate(modChoices!){
                if (choice == -1) {
                    continue 
                }
                modifiers?.append([
                    "uuid":BGData.sharedDataContainer.modifiers![index].uuid,
                    "selected_radio_option_name": BGData.sharedDataContainer.modifiers![index].options![choice].name
                    ])
                modifierAns?.append(BGData.sharedDataContainer.modifiers![index].options![choice].name)
                    productPriceFinal = BGData.sharedDataContainer.modifiers![index].options![choice].price  + productPriceFinal!
            }
        }
    }
    var itemIndex: Int? {
        didSet {
            productId = BGData.sharedDataContainer.groupItems?[fromGroup!].items![itemIndex!].uuid
            productName = BGData.sharedDataContainer.groupItems?[fromGroup!].items![itemIndex!].name
            productPrice = BGData.sharedDataContainer.groupItems?[fromGroup!].items![itemIndex!].price
            productPriceFinal = productPrice
        }
    }
    var modifiers: [Dictionary<String, String>]?
    
    func getParams() -> Dictionary<String, AnyObject>{
        var dict:Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        dict["product_uuid"] = productId
        dict["qty"] = quantity
        dict["modifiers"] = modifiers
        return dict
    }
}
