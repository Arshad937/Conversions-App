//
//  ImageToggleView.swift
//  Converter
//
//  Created by Arshad Mustafa on 09/12/2023.
//

// Design for Image toggle 

import SwiftUI

struct ImageToggleView: View {
    @State private var isImage1Visible = true

    var body: some View {
        VStack {
            if isImage1Visible {
                Image("circle")
                    .resizable()
                    .frame(width: 20, height: 20) // Adjust the frame size as needed
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        // Toggle the state to switch to the other image
                        isImage1Visible.toggle()
                    }
            } else {
                Image("Switch")
                    .resizable()
                    .frame(width: 20, height: 20) // Adjust the frame size as needed
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        // Toggle the state to switch back to the original image
                        isImage1Visible.toggle()
                    }
            }
        }
    }
}

#Preview {
    ImageToggleView()
}
