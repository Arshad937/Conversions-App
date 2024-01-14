//
//  BackgroundView.swift
//  Converter
//
//  Created by Arshad Mustafa on 12/12/2023.
//

// Designing the background image

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("background")
            .resizable()
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
