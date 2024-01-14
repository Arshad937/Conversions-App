//
//  WeightViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 12/12/2023.
//

/* In this code to perform functionality for WeightView */

import Foundation
import SwiftUI

class WeightViewModel : ObservableObject {
    
    @Published var fromValue: String = ""
    @Published var toValue: String = ""
    @Published var fromUnit: String?
    @Published var toUnit: String?
    
    // function to convert one data into other
    func convert() {
        guard let fromUnit = fromUnit, let toUnit = toUnit else {
            return
        }
        
        guard let fromValueDouble = Double(fromValue) else {
            return
        }
        
        // Implement conversion logic based on selected units
        let resultValue: Double
        switch (fromUnit, toUnit) {
        case ("Tonne", "Kilogram"):
            resultValue = fromValueDouble * 1000
        case ("Tonne", "Gram"):
            resultValue = fromValueDouble * 1_000_000
        case ("Kilogram", "Tonne"):
            resultValue = fromValueDouble / 1000
        case ("Kilogram", "Gram"):
            resultValue = fromValueDouble * 1000
        case ("Gram", "Tonne"):
            resultValue = fromValueDouble / 1_000_000
        case ("Gram", "Kilogram"):
            resultValue = fromValueDouble / 1000
        default:
            resultValue = fromValueDouble
        }
        
        // Update the result value
        toValue = String(format: "%.2f", resultValue)
    }
    
    // functionnality of copy button
    func copyToClipboard() {
        UIPasteboard.general.string = toValue
    }
    
    // functionality of share button
    func share() {
        guard !toValue.isEmpty else {
            return
        }
        
        let textToShare = "\(fromValue) \(fromUnit ?? "") is equal to \(toValue) \(toUnit ?? "")"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.assignToContact
        ]
        
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}
