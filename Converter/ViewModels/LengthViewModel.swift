//
//  LengthViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 13/12/2023.
//

/* In this code to perform functionality for LengthView */

import Foundation
import SwiftUI

class LengthViewModel: ObservableObject {
    
    @Published var fromValue: String = ""
    @Published var toValue: String = ""
    @Published var fromUnit: String?
    @Published var toUnit: String?
    
    // function to convert one data to another
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
        case ("Mile", "Foot"):
            resultValue = fromValueDouble * 5280
        case ("Mile", "Meter"):
            resultValue = fromValueDouble * 1609.34
        case ("Foot", "Mile"):
            resultValue = fromValueDouble / 5280
        case ("Foot", "Meter"):
            resultValue = fromValueDouble / 3.28084
        case ("Meter", "Mile"):
            resultValue = fromValueDouble / 1609.34
        case ("Meter", "Foot"):
            resultValue = fromValueDouble * 3.28084
        default:
            resultValue = fromValueDouble
        }

        // Update the result value
        toValue = String(format: "%.2f", resultValue)
    }

    // function to copy data
    func copyToClipboard() {
        UIPasteboard.general.string = toValue
    }

    // function to share data
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
