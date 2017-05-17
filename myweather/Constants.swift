//
//  Constants.swift
//  myweather
//
//  Created by Winston Tabar on 2017/05/12.
//  Copyright © 2017年 Winston Tabar. All rights reserved.
//

import Foundation

// info plist: App Transport Security 
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "c3812040325c6203cdb39a49f3ad5757"

let KELVIN_CONSTANT = 273.15

typealias DownloadComplete = () -> () // TODO: Research 

// api.openweathermap.org/data/2.5/weather?lat=10.32&lon=123.89&appid=c3812040325c6203cdb39a49f3ad5757 
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

// in string interpolcation, the implicitly unwrapped vars will turn back to optional
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=c3812040325c6203cdb39a49f3ad5757"

