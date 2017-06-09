//
//  Extensions.swift
//  WeatherTest
//
//  Created by Vik Denic on 6/9/17.
//  Copyright © 2017 vik. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showAlert(error : Error!, forVC : UIViewController) {
        let alert = UIAlertController(title: error.localizedDescription as String, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        forVC.present(alert, animated: true, completion: nil)
    }
    
}
