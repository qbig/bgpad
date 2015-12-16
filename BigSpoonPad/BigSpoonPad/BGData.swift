//
//  BGData.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 26/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import Socket_IO_Client_Swift

/**
This struct defines the keys used to save the data container singleton's properties to NSUserDefaults.
This is the "Swift way" to define string constants.
*/
struct DefaultsKeys
{
    static let tokenKey  = "tokenKey"
    static let itemKey = "itemKey"
    static let modifierKey = "modifierKey"
    static let lastSyncKey = "lastSyncKey"
}

/**
:Class:   DataContainerSingleton
This class is used to save app state data and share it between classes.
It observes the system UIApplicationDidEnterBackgroundNotification and saves its properties to NSUserDefaults before
entering the background.

Use the syntax `DataContainerSingleton.sharedDataContainer` to reference the shared data container singleton
*/

class BGData
{
    static let sharedDataContainer = BGData()
    
    //------------------------------------------------------------
    //Add properties here that you want to share accross your app
    var webToken: String?
    var lastSync: String?
    var groupItemJson : JSON?
    var groupItems: [GroupItemModel]?
    var modiferJson : JSON?
    var modifiers: [ModifierSection]?
    var attributesJson : JSON?
    var tableJson : JSON?
    var currentOrders:[BGOrder]?
    var currentOrder: BGOrder?
    var currentOrderJson: JSON?
    var newOrderCreated:Bool = false
    //------------------------------------------------------------
    
    var goToBackgroundObserver: AnyObject?
    
    init()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //-----------------------------------------------------------------------------
        //This code reads the singleton's properties from NSUserDefaults.
        //edit this code to load your custom properties
        webToken = defaults.objectForKey(DefaultsKeys.tokenKey) as! String?
        lastSync = defaults.objectForKey(DefaultsKeys.lastSyncKey) as! String?
        if let groupItemJsonStr = defaults.objectForKey(DefaultsKeys.itemKey) as! String? {
            groupItemJson = JSON(groupItemJsonStr)
            if (groupItemJson != nil) {
                groupItems = groupItemJson!.arrayValue.map({groupJson in
                    GroupItemModel(json:groupJson)
                })
            }
        }
        
        if let modiferJsonStr = defaults.objectForKey(DefaultsKeys.modifierKey) as! String? {
            modiferJson = JSON(modiferJsonStr)
            if (modiferJson != nil) {
                self.populateModWithJson()
            }
        }
        
        //-----------------------------------------------------------------------------
        
        //Add an obsever for the UIApplicationDidEnterBackgroundNotification.
        //When the app goes to the background, the code block saves our properties to NSUserDefaults.
        goToBackgroundObserver = NSNotificationCenter.defaultCenter().addObserverForName(
            UIApplicationDidEnterBackgroundNotification,
            object: nil,
            queue: nil)
            {
                (note: NSNotification!) -> Void in
                let defaults = NSUserDefaults.standardUserDefaults()
                //-----------------------------------------------------------------------------
                //This code saves the singleton's properties to NSUserDefaults.
                //edit this code to save your custom properties
                defaults.setObject( self.webToken, forKey: DefaultsKeys.tokenKey)
                defaults.setObject( self.lastSync, forKey: DefaultsKeys.lastSyncKey)
                defaults.setObject( self.groupItemJson?.stringValue, forKey: DefaultsKeys.itemKey)
                defaults.setObject( self.modiferJson?.stringValue, forKey: DefaultsKeys.modifierKey)
                //-----------------------------------------------------------------------------
                
                //Tell NSUserDefaults to save to disk now.
                defaults.synchronize()
        }
    }
    
    func fetchToken () {
        Alamofire.request(.POST, BgConst.Url.Login)
            .authenticate(user: "1234", password: "1234")
            .responseJSON {response in
                guard let value = response.result.value else {
                    print("Error: did not receive data")
                    return
                }
                
                guard response.result.error == nil else {
                    print("error calling GET on /posts/1")
                    print(response.result.error)
                    return
                }

                let jsonData = JSON(value)
                if let webToken = jsonData[BgConst.Key.Token].string {
                    BGData.sharedDataContainer.webToken = webToken
                    NSNotificationCenter.defaultCenter().postNotificationName(BgConst.Key.NotifTokenDone, object:nil)
                }
                print(jsonData)
                print("======= login done =======")
        }
    }
    
    func createNewOrder() {
        let postBody = [
            "pax":1,
            "type": "eat-in"
        ]
        Alamofire.request(.POST, BgConst.Url.Order, parameters:postBody)
            .responseJSON {response in
                guard let value = response.result.value else {
                    print("Error: did not receive data")
                    return
                }
                
                guard response.result.error == nil else {
                    print("error calling GET on /posts/1")
                    print(response.result.error)
                    return
                }

                print("======= load \(BgConst.Url.Order) done =======")
                print(JSON(value))

                    BGData.sharedDataContainer.currentOrders = []
                    BGData.sharedDataContainer.currentOrder = BGOrder()
                    BGData.sharedDataContainer.currentOrderJson = JSON(value)
                    NSNotificationCenter.defaultCenter().postNotificationName(BgConst.Key.NotifNewOrderCreated, object: nil)

        }
        //        CREATE
        //        {
        //            "order_items": [],
        //            "uuid": "141129AMK00029",
        //            "staff_id": 1,
        //            "pax": 1,
        //            "type": "eat-in",
        //            "subtotal_adj_amt": 0,
        //            "subtotal_adj_type": "value",
        //            "subtotal_adj_entry_type": "discount",
        //            "adjustments": [
        //            {
        //            "uuid": "10_percent_off",
        //            "amt": 10,
        //            "type": "percent",
        //            "entry_type": "discount"
        //            }
        //            ],
        //            "createdAt": "2014-11-29T10:55:33.068Z",
        //            "updatedAt": "2014-11-29T10:55:33.078Z",
        //            "state": "opened",
        //            "table_id": 1,
        //            "notes": "Allergic to peanuts"
        //        }
        
        //        ADD ITEMS
        //        [
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
        //                ],
        //                "createdAt": "2015-02-03T08:07:56.188Z"
        //            }
        //        ]
        
    }
    
    func completeOrder() {
        var postBody = [[String:AnyObject]]()
        for order in currentOrders! {
            postBody.append(order.getParams())
        }
        if let uuid = BGData.sharedDataContainer.currentOrderJson?["uuid"].string {
            let url = "\(BgConst.Url.Order)/\(uuid)/item"
            let URL = NSURL(string: url)
            let request = NSMutableURLRequest(URL: URL!)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(webToken, forHTTPHeaderField: "X-Web-Token")
            do {
                try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(postBody, options: [])
                Alamofire.request(request)
                    .responseJSON { response in
                        guard let value = response.result.value else {
                            print("Error: did not receive data")
                            return
                        }
                        
                        guard response.result.error == nil else {
                            print("error calling GET on /posts/1")
                            print(response.result.error)
                            return
                        }
                        
                        print("======= load \(url) ,add Items =======")
                        print(JSON(value))

                            BGData.sharedDataContainer.currentOrders = []
                            BGData.sharedDataContainer.currentOrder = BGOrder()
                            BGData.sharedDataContainer.currentOrderJson = JSON(value)
                            NSNotificationCenter.defaultCenter().postNotificationName(BgConst.Key.NotifOrderItemsAdded, object: nil)

                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func startSocketIO() {
        print("startSocketIO called.")
        //        let options = ["connectParams":["webToken" :BGData.sharedDataContainer.webToken!]]
        print(BgConst.Url.Base + BGData.sharedDataContainer.webToken!)
        let socket = SocketIOClient(socketURL: BgConst.Url.Base + BGData.sharedDataContainer.webToken!)
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        socket.on("productattribute") {data, ack in
            print("something is out of stock!")
        }
        
        socket.on("error") {data, ack in
            print("socket connected FAILED")
            print(data)
            print(ack)
        }
        socket.onAny{event in
            print(event)
        }
        
        socket.connect()
    }
    
    
    func loadOrderData() {
        loadData(BgConst.Url.Order).responseJSON {response in
            guard let _ = response.result.value else {
                print("Error: did not receive data")
                return
            }
            
            guard response.result.error == nil else {
                print("error calling GET on /posts/1")
                print(response.result.error)
                return
            }
        }
    }
    
    func loadTableData() {
        loadData(BgConst.Url.Table).responseJSON { response in
            debugPrint(response)
            guard let value = response.result.value else {
                print("Error: did not receive data")
                return
            }
            
            guard response.result.error == nil else {
                print("error calling GET on /posts/1")
                print(response.result.error)
                return
            }
            BGData.sharedDataContainer.tableJson = JSON(value)
        }
    }
    
    func loadGroupItemData() {
        loadData(BgConst.Url.GroupItems).responseJSON {response in
            debugPrint(response)
            guard let value = response.result.value else {
                print("Error: did not receive data")
                return
            }
            
            guard response.result.error == nil else {
                print("error calling GET on /posts/1")
                print(response.result.error)
                return
            }
            
            if let lastSync = response.response?.allHeaderFields["Date"]  as? String{
                print(lastSync)
                BGData.sharedDataContainer.lastSync = lastSync
            }
            let json = JSON(value)
            BGData.sharedDataContainer.groupItemJson = json
            BGData.sharedDataContainer.groupItems = json.arrayValue.map({groupJson in
                GroupItemModel(json:groupJson)
            })
        }
    }
    
    func loadModifierData() {
        loadData(BgConst.Url.Modifier).responseJSON {response in
            guard let value = response.result.value else {
                print("Error: did not receive data")
                return
            }
            
            guard response.result.error == nil else {
                print("error calling GET on /posts/1")
                print(response.result.error)
                return
            }
            BGData.sharedDataContainer.modiferJson = JSON(value)
            self.populateModWithJson()
        }
    }
    
    func populateModWithJson() {
        BGData.sharedDataContainer.modifiers = [ModifierSection]()
        for modJson in BGData.sharedDataContainer.modiferJson!.arrayValue {
            let descrip = modJson["description"].stringValue
            let price:Double = modJson["price"].doubleValue
            let name = modJson["name"].stringValue
            let uuid = modJson["uuid"].stringValue
            var opts = [AnyObject]()
            for op in modJson["radio_options"].arrayValue {
                opts.append(["name":op["name"].stringValue, "price":op["price"].numberValue])
            }
            let dict = ["name": name, "description": descrip, "price": price, "options": opts, "uuid":uuid]
            BGData.sharedDataContainer.modifiers?.append(ModifierSection(dict:dict as! [NSObject : AnyObject]))
        }
    }
    
    func loadItemAttributeData() {
        loadData(BgConst.Url.ItemsAttributes).responseJSON { response in
            debugPrint(response)
            guard let value = response.result.value else {
                print("Error: did not receive data")
                return
            }
            
            guard response.result.error == nil else {
                print("error calling GET on /posts/1")
                print(response.result.error)
                return
            }
            BGData.sharedDataContainer.attributesJson = JSON(value)
        }
    }
    
    func loadData(url:String) -> Request{
        return Alamofire.request(.GET, url).responseJSON {response in
            guard let value = response.result.value else {
                print("Error: did not receive data")
                return
            }
            
            guard response.result.error == nil else {
                print("error calling GET on /posts/1")
                print(response.result.error)
                return
            }

            print("======= load \(url) done =======")
            print(JSON(value))
        }
    }

}