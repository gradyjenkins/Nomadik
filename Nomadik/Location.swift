//
//  Location.swift
//  Nomadik
//
//  Created by Grady Jenkins on 4/10/17.
//  Copyright © 2017 Monmouth University. All rights reserved.
//

import Foundation
class Location: NSObject
{
    var state: String
    var city: String
    var longitude: String
    var latitude: String
    
    init(state: String, city: String, longitude: String, latitude: String) {
        self.state = state
        self.city = city
        self.longitude = longitude
        self.latitude = latitude
    }
    
   
}
