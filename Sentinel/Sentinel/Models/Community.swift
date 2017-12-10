//
//  Community.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//


import Foundation

struct Community {
    
    let uid: String
    let communityName: String
    let communityImageUrl: String
    
    let numberOfLicensePlates : UInt
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.communityName = dictionary["communityName"] as? String ?? ""
        self.communityImageUrl = dictionary["communityImageUrl"]  as? String ?? ""
        
        self.numberOfLicensePlates = dictionary["numberOfLicensePlates"] as? UInt ?? 0
        
        
        
    }
}
