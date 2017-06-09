//
//  ViewController.swift
//  WeatherTest
//
//  Created by Vik Denic on 6/9/17.
//  Copyright © 2017 vik. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {


    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
        didSet {
            retrieveLocalWeather()
        }
    }
    
    var forecast: Forecast! {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSetup()
        zipTextField.becomeFirstResponder()
    }
    
    func locationSetup() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func retrieveLocalWeather() {
        WeatherManager.forecast(forLocation: currentLocation!) { (forecast, error) in
            if error == nil {
                self.forecast = forecast
            } else {
                UIAlertController.showAlert(error: error, forVC: self)
            }
        }
    }
    
    func updateUI() {
        if let forecast = forecast {
            nameLabel.text = forecast.locationName
            infoLabel.text = "High: \(forecast.tempMax!) | Low: \(forecast.tempMin!)"
            iconImageView.image = UIImage(named: forecast.icon)
        }
    }
    
    @IBAction func onDoneTapped(_ sender: UIBarButtonItem) {
        if !(zipTextField.text?.isEmpty)! {
            WeatherManager.forecast(forZipcode: zipTextField.text!) { (forecast, error) in
                if error == nil {
                    self.forecast = forecast
                } else {
                    UIAlertController.showAlert(error: error, forVC: self)
                }
            }
        }
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            locationManager.stopUpdatingLocation()
        }
    }
}

