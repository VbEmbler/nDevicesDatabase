//
//  DeviceData.swift
//  DevicesDatabase
//
//  Created by Vladimir on 01/03/2020.
//  Copyright © 2020 Embler. All rights reserved.
//

import UIKit
import ObjectMapper

class DeviceData: Mappable {

    //Mark: Properites
    var userId: String?
    var deviceName: String? = nil
    var deviceModel: String?
    var osVersion: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.userId      <- map["userID"]
        self.deviceName  <- map["deviceName"]
        self.deviceModel <- map["deviceModel"]
        self.osVersion   <- map["os_version"]
    }
    //Mark: Initialization
//    init(userId: String, deviceName: String, deviceModel: String, osVersion: String){
//
//        self.userId = userId
//        self.deviceName = deviceName
//        self.deviceModel = deviceModel
//        self.osVersion = osVersion
//    }
}
