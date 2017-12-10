//
//  Vehicle.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//


import Foundation

struct Vehicle {

    var id: String?

    
    let user: User
    //let uidOfOwner: String
    let vehicleBrand: String
    let vehicleModel: String
    let licensePlateNumber: String
    //let vehicleImageUrl: String
    
    //let numberOfLicensePlates : UInt
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.vehicleBrand = dictionary["vehicle_brand"] as? String ?? ""
        self.vehicleModel = dictionary["vehicle_model"] as? String ?? ""
        self.licensePlateNumber = dictionary["license_plate_number"] as? String ?? ""

        //self.vehicleImageUrl = dictionary["vehicleImageUrl"]  as? String ?? ""
        
       // self.numberOfLicensePlates = dictionary["numberOfLicensePlates"] as? UInt ?? 0
        
        
        
    }
}
