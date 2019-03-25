//
//  AddRunDataController.swift
//  RunApp
//
//  Created by Jack Terry on 3/24/19.
//  Copyright © 2019 Jack Terry. All rights reserved.
//

import UIKit

class AddRunDataController {
    
    private let viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Alerts for when specific text fields have not been entered
    public func dateAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter a valid date.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    public func distanceAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter a valid distance.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    public func timeAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter a valid time.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Helper funciton to determine if a UITextField is nil or empty
    public func isNilOrEmpty(textField: UITextField) -> Bool {
        if textField.text == nil || textField.text == "" {
            return true
        }
        return false
    }
    
    // MARK: - Function for calculating pace given all text fields in AddRunViewController contain values
    public func calculatePace(distance: String, hours: String, minutes: String, seconds: String) -> String {
        let distance: Double = Double(distance)!
        
        let hours: Double = Double(hours) ?? 0.0
        let minutes: Double = Double(minutes) ?? 0.0
        let seconds: Double = Double(seconds) ?? 0.0
        let totalTime = hours * 3600 + minutes * 60 + seconds
        
        let paceTotalTime = totalTime / distance
        let paceHours = String(Int(paceTotalTime / 3600))
        let paceMinutes = String(Int(paceTotalTime / 60) - (Int(paceHours) ?? 0 * 3600))
        let paceSeconds = String(format: "%04.1f", Double(paceTotalTime.truncatingRemainder(dividingBy: 60)))
        
        return Int(paceHours) == 0 ? paceMinutes + ":" + paceSeconds : paceHours + ":" + paceMinutes + ":" + paceSeconds
    }
}
