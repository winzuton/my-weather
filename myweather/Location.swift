//
//  Location.swift
//  myweather
//
//  Created by Winston Tabar on 2017/05/14.
//  Copyright © 2017年 Winston Tabar. All rights reserved.
//

import Foundation
import CoreLocation

// singleton class 
class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
