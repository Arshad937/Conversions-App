//
//  AreaViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 13/12/2023.
//

/* In this code to perform functionality for AreaView */

import Foundation
import SwiftUI

class AreaViewModel: ObservableObject {
    
    @Published var fromValue: String = ""
    @Published var toValue: String = ""
    @Published var fromUnit: String?
    @Published var toUnit: String?
    
    // function to convert one data
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
        case ("Square Kilometer", "Square Yard"):
            resultValue = fromValueDouble * 1195990.05
        case ("Square Kilometer", "Square Foot"):
            resultValue = fromValueDouble * 10763910.4
        case ("Square Yard", "Square Kilometer"):
            resultValue = fromValueDouble / 1195990.05
        case ("Square Yard", "Square Foot"):
            resultValue = fromValueDouble * 9
        case ("Square Foot", "Square Kilometer"):
            resultValue = fromValueDouble / 10763910.4
        case ("Square Foot", "Square Yard"):
            resultValue = fromValueDouble / 9
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
