//
//  GroupItemModel.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 3/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import SwiftyJSON
//{
//    "products" : [
//    
//    ],
//    "name" : "Terrior",
//    "photos" : [
//    "https:\/\/storage.googleapis.com\/sphere-test-assets\/store\/sun-tea-asset\/terroir.jpg"
//    ],
//    "id" : 1,
//    "description" : "Terrior"
//}
//
//{
//    "products" : [
//    {
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
//      },
// ...
//     ],
//"name" : "Rich",
//"photos" : [
//"https:\/\/storage.googleapis.com\/sphere-test-assets\/store\/sun-tea-asset\/rich.jpg"
//],
//"id" : 4,
//"description" : "Rich"
//}
class GroupItemModel: NSObject {
    var name: String?
    var photo: String?
    var id: Int?
    var groupDescription: String?
    var items: [ItemModel]?
    init(json: JSON) {
        name = json["name"].stringValue
        groupDescription = json["description"].stringValue
        photo = json["photos", 0].stringValue
        id = json["id"].intValue
        items = json["products"].arrayValue.map({prodJson in
            ItemModel(json:prodJson)
        })
    }
}
