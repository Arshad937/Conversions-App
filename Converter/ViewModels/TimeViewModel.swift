//
//  TimeViewModel.swift
//  Converter
//
//  Created by Arshad Mustafa on 13/12/2023.
//

/* In this code to perform functionality for TimeView */

import Foundation
import SwiftUI

class TimeViewModel: ObservableObject {
    
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
        case ("Hour", "Minute"):
            resultValue = fromValueDouble * 60
        case ("Hour", "Second"):
            resultValue = fromValueDouble * 3600
        case ("Minute", "Hour"):
            resultValue = fromValueDouble / 60
        case ("Minute", "Second"):
            resultValue = fromValueDouble * 60
        case ("Second", "Hour"):
            resultValue = fromValueDouble / 3600
        case ("Second", "Minute"):
            resultValue = fromValueDouble / 60
        default:
            resultValue = fromValueDouble
        }

        // Update the result value
        toValue = String(format: "%.2f", resultValue)
    }

    // function to copy data into clipboard
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
