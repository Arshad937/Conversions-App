//
//  SpeedViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 12/12/2023.
//

/* In this code to perform functionality for SpeedView */

import Foundation
import SwiftUI

class SpeedViewModel : ObservableObject {
    
    @Published var fromValue: String = ""
    @Published var toValue: String = ""
    @Published var fromUnit: String?
    @Published var toUnit: String?
    
    // function to convert data
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
        case ("Mile per Hour", "Kilometer per Hour"):
            resultValue = fromValueDouble * 1.60934
        case ("Mile per Hour", "Meter per Second"):
            resultValue = fromValueDouble * 0.44704
        case ("Kilometer per Hour", "Mile per Hour"):
            resultValue = fromValueDouble / 1.60934
        case ("Kilometer per Hour", "Meter per Second"):
            resultValue = fromValueDouble / 3.6
        case ("Meter per Second", "Mile per Hour"):
            resultValue = fromValueDouble / 0.44704
        case ("Meter per Second", "Kilometer per Hour"):
            resultValue = fromValueDouble * 3.6
        default:
            resultValue = fromValueDouble
        }

        // Update the result value
        toValue = String(format: "%.2f", resultValue)
    }

    // functionality of copy button
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
