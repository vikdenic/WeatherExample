//
//  WeatherMgr.swift
//  WeatherTest
//
//  Created by Vik Denic on 6/9/17.
//  Copyright © 2017 vik. All rights reserved.
//

import Foundation
import CoreLocation

let kWeatherAPIkey = "80b6ffc38027ff4c6828eee008acf946"
let kWeatherBaseURL = "http://api.openweathermap.org/data/2.5/weather?"

class WeatherManager {
    /// Returns Forecast for provided zipcode
    ///
    /// - parameter complete: The completion block of the network call, returning a forecast and/or an error
    class func forecast(forZipcode zipcode: String, complete : @escaping (_ forecast : Forecast?, _ error: Error?) -> Void) {
        let path = "\(kWeatherBaseURL)zip=\(zipcode),us&units=imperial&appid=\(kWeatherAPIkey)"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = NSMutableURLRequest(url: NSURL(string: path as String)! as URL)
        request.httpMethod = "GET"
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                if let data = data {
                    let weatherDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                    DispatchQueue.main.async {
                        let forecast = Forecast(dict: weatherDict)
                        complete(forecast, error)
                    }
                }
            } catch {
                complete(nil, error)
            }
        }
        task.resume()
    }
    
    /// Returns Forecast for provided CLLocation
    ///
    /// - parameter complete: The completion block of the network call, returning a forecast and/or an error
    class func forecast(forLocation location: CLLocation, complete : @escaping (_ forecast : Forecast?, _ error: Error?) -> Void) {
        let path = "\(kWeatherBaseURL)lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=imperial&appid=\(kWeatherAPIkey)"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = NSMutableURLRequest(url: NSURL(string: path as String)! as URL)
        request.httpMethod = "GET"
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                if let data = data {
                    let weatherDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                    DispatchQueue.main.async {
                        let forecast = Forecast(dict: weatherDict)
                        complete(forecast, error)
                    }
                }
            } catch {
                complete(nil, error)
            }
        }
        task.resume()
    }
    
}
