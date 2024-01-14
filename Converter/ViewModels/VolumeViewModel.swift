//
//  VolumeViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 12/12/2023.
//

/* In this code to perform functionality for VolumeView */

import Foundation
import SwiftUI

class VolumeViewModel : ObservableObject {
    
    @Published var fromValue: String = ""
    @Published var toValue: String = ""
    @Published var fromUnit: String?
    @Published var toUnit: String?

    // function to convert one data to other
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
        case ("Liter", "Milliliter"):
            resultValue = fromValueDouble * 1000
        case ("Liter", "Imperial Pint"):
            resultValue = fromValueDouble * 1.76
        case ("Milliliter", "Liter"):
            resultValue = fromValueDouble / 1000
        case ("Milliliter", "Imperial Pint"):
            resultValue = fromValueDouble * 0.00176
        case ("Imperial Pint", "Liter"):
            resultValue = fromValueDouble / 1.76
        case ("Imperial Pint", "Milliliter"):
            resultValue = fromValueDouble / 0.00176
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
