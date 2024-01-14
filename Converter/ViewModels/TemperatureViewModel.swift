//
//  TemperatureViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 12/12/2023.
//

/* In this code to perform functionality for TemperatureView */

import Foundation
import SwiftUI

class TemperatureViewModel: ObservableObject {
    
    @Published var fromValue: String = ""
    @Published var toValue: String = ""
    @Published var fromUnit: String?
    @Published var toUnit: String?
    
        // function to convert one data into other
        func convert() {
            guard let fromUnit = fromUnit, let toUnit = toUnit else {
                // Handle the case when units are not selected
                return
            }
    
            guard let fromValueDouble = Double(fromValue) else {
                // Handle the case when the input value is not a valid number
                return
            }
    
            // Implement conversion logic based on selected units
            let resultValue: Double
            switch (fromUnit, toUnit) {
            case ("Forenheight", "Celsius"):
                resultValue = (fromValueDouble - 32) * 5/9
            case ("Forenheight", "Kelvin"):
                resultValue = (fromValueDouble - 32) * 5/9 + 273.15
            case ("Celsius", "Forenheight"):
                resultValue = fromValueDouble * 9/5 + 32
            case ("Celsius", "Kelvin"):
                resultValue = fromValueDouble + 273.15
            case ("Kelvin", "Forenheight"):
                resultValue = (fromValueDouble - 273.15) * 9/5 + 32
            case ("Kelvin", "Celsius"):
                resultValue = fromValueDouble - 273.15
            default:
                // Handle the case when units are the same
                resultValue = fromValueDouble
            }
    
            // Update the result value
            toValue = String(format: "%.2f", resultValue)
        }
    
        // function for copy button .
        func copyToClipboard() {
            UIPasteboard.general.string = toValue
        }
    
        // function for share button
        func share() {
            guard !toValue.isEmpty else {
                // Handle the case when there is nothing to share
                return
            }
    
            let textToShare = "\(fromValue) \(fromUnit ?? "") is equal to \(toValue) \(toUnit ?? "")"
            let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
    
            // You can exclude some activities if needed
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.assignToContact
            ]
    
            // Present the view controller
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
