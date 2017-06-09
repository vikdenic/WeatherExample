//
//  Forecast.swift
//  WeatherTest
//
//  Created by Vik Denic on 6/9/17.
//  Copyright © 2017 vik. All rights reserved.
//

import Foundation

/// ⛅️ Represents the weather for a certain location
class Forecast {
    var tempMin: Float!
    var tempMax: Float!
    var locationName: String!
    var icon: String!
    
    init(dict: [String : Any]) {
        if let weatherArray = dict["weather"] {
            let weatherDict = (weatherArray as! [Any]).first
            icon = (weatherDict as! [String : Any])["icon"] as! String
        }
        
        if let mainDict = dict["main"] {
            tempMin = (mainDict as! [String : Any])["temp_min"] as! Float
            tempMax = (mainDict as! [String : Any])["temp_max"] as! Float
        }
        
        if let name = dict["name"] {
            locationName = name as! String
        }
    }
    
}
