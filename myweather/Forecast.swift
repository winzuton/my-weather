//
//  Forecast.swift
//  myweather
//
//  Created by Winston Tabar on 2017/05/13.
//  Copyright © 2017年 Winston Tabar. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {

    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    
    init(weatherDict: Dictionary<String, Any>) {
        print("init area")
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            if let min = temp["min"] as? Double {
                let celciusValue = (min - KELVIN_CONSTANT)
                self._lowTemp = String(format: "%.0f°", celciusValue)
                print(self._lowTemp)
            }
            if let max = temp["max"] as? Double {
                let celciusValue = (max - KELVIN_CONSTANT)
                self._highTemp = String(format: "%.0f°", celciusValue)
                print(_highTemp)
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                print(_weatherType)
            }
        }
        if let date = weatherDict["dt"] as? Double {
            // convert unix time stamp to standard Gregorian Calendar date 
            let unixConvertedDate = Date(timeIntervalSince1970: date)
              /* let dateFormatter = DateFormatter() // need?
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none */
            self._date = unixConvertedDate.dayOfTheWeek()
            print(_date)
        }
    }
    
}

// outside of the class
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self) // get within class 
    }
}
