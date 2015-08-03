//
//  ItemModel.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 3/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import SwiftyJSON


//{
//    "receipt_name" : "Royal M. Tea",
//    "description" : "Mild fruity notes and cold-pressed juice concentrates",
//    "price" : 590,
//    "avail_modifiers" : [
//    "temperature",
//    "size",
//    "sweetness",
//    "topping"
//    ],
//    "name" : "Royal Milk Tea",
//    "unit_multiplier" : null,
//    "photos" : [
//    "https:\/\/storage.googleapis.com\/sphere-test-assets\/store\/sun-tea-asset\/Food_Drinks_Chamomile_tea_028999_.jpg"
//    ],
//    "unit" : "item",
//    "unit_name" : null,
//    "upc" : "101",
//    "uuid" : 101
//},
class ItemModel: NSObject {
    var receiptName: String?
    var itemDescription: String?
    var price: Double?
    var modifiers: [String?]?
    var name: String?
    var unitMultiplier: AnyObject?
    var unitName: String?
    var photo: String?
    var unit: String?
    var upc: String?
    var uuid : Int?
    
    init(json : JSON) {
        receiptName = json["receipt_name"].stringValue
        itemDescription = json["description"].stringValue
        price = json["price"].doubleValue
        modifiers = json["avail_modifiers"].arrayValue.map({opt in opt.string})
        name = json["name"].stringValue
        unitMultiplier = json["unit_multiplier"].stringValue
        unitName = json["receipt_name"].stringValue
        photo = json["photos", 0].string
        unit = json["unit"].stringValue
        upc = json["upc"].stringValue
        uuid = json["uuid"].intValue
    }
}
