//
//  Constants.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//


struct BgConst {
    struct Url {
        static let Base = "http://104.199.131.157?webToken="
        static let Login = "http://104.199.131.157/auth/login?posGuid=ghi"
        static let Modifier = "http://104.199.131.157/provisioning/product/modifiers"
        static let GroupItems = "http://104.199.131.157/provisioning/product/groups"
        static let ItemsAttributes = "http://104.199.131.157/product_attribute"
        static let Order = "http://104.199.131.157/order"
        static let Table = "http://104.199.131.157/table"
    }
    
    struct Key {
        static let Token = "webToken"
        static let NotifTokenDone = "tokenDone"
        static let NotifNewOrderCreated = "newOrderCreated"
        static let NotifOrderItemsAdded = "newItemsAdded"
        static let NotifModSelectChange = "modifierSelectChange"
        static let NotifModalCancelBtnPressed = "cancelButtonPressed"
        static let NotifModalConfirmBtnPressed = "confirmButtonPressed"
    }
}
