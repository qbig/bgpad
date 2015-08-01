//
//  BGData.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 26/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import Foundation
import UIKit


/**
This struct defines the keys used to save the data container singleton's properties to NSUserDefaults.
This is the "Swift way" to define string constants.
*/
struct DefaultsKeys
{
    static let someString  = "someString"
    static let someOtherString  = "someOtherString"
    static let someInt  = "someInt"
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
    var someString: String?
    var someOtherString: String?
    var someInt: Int?
    var webToken: String?
    //------------------------------------------------------------
    
    var goToBackgroundObserver: AnyObject?
    
    init()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        //-----------------------------------------------------------------------------
        //This code reads the singleton's properties from NSUserDefaults.
        //edit this code to load your custom properties
        someString = defaults.objectForKey(DefaultsKeys.someString) as! String?
        someOtherString = defaults.objectForKey(DefaultsKeys.someOtherString) as! String?
        someInt = defaults.objectForKey(DefaultsKeys.someInt) as! Int?
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
                defaults.setObject( self.someString, forKey: DefaultsKeys.someString)
                defaults.setObject( self.someOtherString, forKey: DefaultsKeys.someOtherString)
                defaults.setObject( self.someInt, forKey: DefaultsKeys.someInt)
                //-----------------------------------------------------------------------------
                
                //Tell NSUserDefaults to save to disk now.
                defaults.synchronize()
        }
    }
}