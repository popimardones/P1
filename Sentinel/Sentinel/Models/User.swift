//
//  User.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    let numberOfVehiclesRegistered : UInt
    let numberOfCommunitiesJoined : UInt

    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
        
        self.numberOfVehiclesRegistered = dictionary["numberOfVehiclesRegistered"] as? UInt ?? 0
        self.numberOfCommunitiesJoined = dictionary["numberOfCommunitiesJoined"] as? UInt ?? 0

        
        
        
    }
}
