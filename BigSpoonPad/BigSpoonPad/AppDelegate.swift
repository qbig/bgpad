//
//  AppDelegate.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 25/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Socket_IO_Client_Swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Alamofire.request(.POST, BgConst.Url.Login)
            .authenticate(user: "1234", password: "1234")
            .responseJSON { _, _, RawJSON, error in
                let jsonData = JSON(RawJSON!)
                if let webToken = jsonData[BgConst.Key.Token].string {
                    BGData.sharedDataContainer.webToken = webToken
                    NSNotificationCenter.defaultCenter().postNotificationName(BgConst.Key.NotifTokenDone, object:nil)
                }
                println(jsonData)
                println(error)
                println("======= login done =======")
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tokenReadyHandler"), name: BgConst.Key.NotifTokenDone, object: nil)
        return true
    }
    
    func tokenReadyHandler() {
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["X-Web-Token": BGData.sharedDataContainer.webToken!]
        loadOrderData()
        createNewOrder()
        loadTableData()
        loadGroupItemData()
        loadModifierData()
        loadItemAttributeData()
        startSocketIO()
    }
    
    func startSocketIO() {
        println("startSocketIO called.")
//        let options = ["connectParams":["webToken" :BGData.sharedDataContainer.webToken!]]
        println(BgConst.Url.Base + BGData.sharedDataContainer.webToken!)
        let socket = SocketIOClient(socketURL: BgConst.Url.Base + BGData.sharedDataContainer.webToken!)

        socket.on("connect") {data, ack in
            println("socket connected")
        }
        
        socket.on("productattribute") {data, ack in
            println("something is out of stock!")
        }
        
        socket.on("error") {data, ack in
            println("socket connected FAILED")
            println(data)
            println(ack)
        }
        socket.onAny{event in
            println(event)
        }
        
        socket.connect()
    }
    
    
    func loadOrderData() {
        loadData(BgConst.Url.Order).responseJSON { request, response, RawJSON, error in

        }
    }
    
    func createNewOrder() {
        let postBody = [
            "table_id":0,
            "pax":1,
            "type": "eat-in"
        ]
        Alamofire.request(.POST, BgConst.Url.Order, parameters:postBody)
            .responseJSON { _, _, rawJson, error in
                println("error: \(error)")
                println("======= load \(BgConst.Url.Order) done =======")
                println(JSON(rawJson!))
        }
    }

    func loadTableData() {
        loadData(BgConst.Url.Table).responseJSON { request, response, RawJSON, error in
            BGData.sharedDataContainer.tableJson = JSON(RawJSON!)
        }
    }
    
    func loadGroupItemData() {
        loadData(BgConst.Url.GroupItems).responseJSON { request, response, RawJSON, error in
            if let lastSync = response?.allHeaderFields["Date"]  as? String{
                println(lastSync)
                BGData.sharedDataContainer.lastSync = lastSync
            }
            BGData.sharedDataContainer.groupItemJson = JSON(RawJSON!)
        }
    }
    
    func loadModifierData() {
        loadData(BgConst.Url.Modifier).responseJSON { request, response, RawJSON, error in
            BGData.sharedDataContainer.modiferJson = JSON(RawJSON!)
        }
    }
    
    func loadItemAttributeData() {
        loadData(BgConst.Url.ItemsAttributes).responseJSON { request, response, RawJSON, error in
            BGData.sharedDataContainer.attributesJson = JSON(RawJSON!)
        }
    }
    
    func loadData(url:String) -> Request{
        return Alamofire.request(.GET, url).responseJSON { _, _, rawJson, error in
            println("error: \(error)")
            println("======= load \(url) done =======")
            println(JSON(rawJson!))
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

