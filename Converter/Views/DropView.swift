//
//  DropView.swift
//  Converter
//
//  Created by Arshad Mustafa on 11/12/2023.
//

// Designing the DropDown 

import SwiftUI

struct DropView: View {
    @State private var isDropdownVisible = false
    @Binding private var selectedItem: String?
    

    let items: [String]

    init(selectedItem: Binding<String?>? = nil, items: [String] = []) {
        self._selectedItem = selectedItem ?? Binding.constant(nil)
        self.items = items
    }
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 136, height: 35)
                .foregroundColor(Color(hex: "596ADE"))
                .overlay(
                    HStack {
                        Text(selectedItem ?? "Select")
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        Spacer()
                        Image("arrow")
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                            .onTapGesture {
                                withAnimation {
                                    isDropdownVisible.toggle()
                                }
                            }
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.white, lineWidth: 1)
                )

            if isDropdownVisible {
                Rectangle()
                    .cornerRadius(27)
                    .frame(width: 202, height: 172)
                    .foregroundColor(Color(hex: "596ADE"))
                    .overlay(
                        VStack {

                            ForEach(items, id: \.self) { item in
                                Button(action: {
                                    withAnimation {
                                        selectedItem = item
                                        isDropdownVisible.toggle()
                                    }
                                }) {
                                    ImageToggleView()
                                    Text(item)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 10)
                                }
                            }
                        }
                    )
            }
        }
    }
}

// Utility extension to create Color from hex string
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            .sRGB,
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

#Preview {
    DropView()
}
