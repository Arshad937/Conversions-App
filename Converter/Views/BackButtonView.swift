//
//  BackButtonView.swift
//  Converter
//
//  Created by Arshad Mustafa on 08/12/2023.
//

// Design and funtion for back button

import SwiftUI

struct BackButtonView: View {
    var body: some View {
            VStack {
                HStack {
                    NavigationLink {
                        HomeView()
                    } label: {
                        Image("back")
                            .padding()
                        Spacer() // Add spacer to push the back image to the top-leading corner
                    }
                }
                Spacer()
                
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 750)
    }
}

#Preview {
    BackButtonView()
}
