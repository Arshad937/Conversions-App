//
//  PressureViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 13/12/2023.
//

/* In this code to perform functionality for PressureView */

import Foundation
import SwiftUI

class PressureViewModel: ObservableObject {
    
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
        case ("Bar", "Torr"):
            resultValue = fromValueDouble * 750.061683
        case ("Bar", "Pascal"):
            resultValue = fromValueDouble * 100000
        case ("Torr", "Bar"):
            resultValue = fromValueDouble / 750.061683
        case ("Torr", "Pascal"):
            resultValue = fromValueDouble * 133.322368
        case ("Pascal", "Bar"):
            resultValue = fromValueDouble / 100000
        case ("Pascal", "Torr"):
            resultValue = fromValueDouble / 133.322368
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
