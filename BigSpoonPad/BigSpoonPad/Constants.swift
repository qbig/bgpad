//
//  Constants.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//


struct BgConst {
    struct Url {
        //http://104.199.131.157
        static let Base = "http://private-ef689-matrixposauth.apiary-mock.com?webToken="
        static let Login = "http://private-ef689-matrixposauth.apiary-mock.com/auth/login?posGuid=ghi"
        static let Modifier = "http://private-ef689-matrixposauth.apiary-mock.com/provisioning/product/modifiers"
        static let GroupItems = "http://private-ef689-matrixposauth.apiary-mock.com/provisioning/product/groups"
        static let ItemsAttributes = "http://private-ef689-matrixposauth.apiary-mock.com/product_attribute"
        static let Order = "http://private-ef689-matrixposauth.apiary-mock.com/order"
        static let Table = "http://private-ef689-matrixposauth.apiary-mock.com/table"
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
