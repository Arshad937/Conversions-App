//
//  WeightView.swift
//  Converter
//
//  Created by Arshad Mustafa on 08/12/2023.
//

// Design Weight View

import SwiftUI
import Combine

struct WeightView: View {
    @StateObject private var viewModel = WeightViewModel() // Get data from WeightViewModel()

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                NavigationLink {
                    HomeView()
                } label: {
                    Image("back")
                        .frame(width: 350, alignment: .leading)
                }
                Text("Weight")
                    .font(.title)
                    .bold()
                    .frame(width: 200, height: 100, alignment: .bottom)
                    .foregroundColor(.white)

                // From Section
                VStack(alignment: .leading) {
                    Text("From:")
                        .foregroundColor(.white)
                        .bold()
                    HStack {
                        ZStack(alignment: .leading) {
                            if viewModel.fromValue.isEmpty {
                                Text("Enter value")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding()
                            }
                            TextField("", text: $viewModel.fromValue)
                                .frame(width: 136, height: 35)
                                .foregroundColor(.white)
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .onReceive(Just(viewModel.fromValue)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.viewModel.fromValue = filtered
                                    }
                                }
                                .padding(.horizontal, 5)
                        }
                        DropView(selectedItem: $viewModel.fromUnit, items: ["Tonne", "Kilogram", "Gram"])
                    }
                }

                // To Section
                VStack(alignment: .leading) {
                    HStack {
                        Text("To:")
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                        Image("twoarrows")
                    }
                    HStack {
                        ZStack(alignment: .leading) {
                            if viewModel.toValue.isEmpty {
                                Text("Result")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding()
                            }
                            TextField("", text: $viewModel.toValue)
                                .frame(width: 136, height: 35)
                                .foregroundColor(.white)
                                .keyboardType(.decimalPad)
                                .padding(.horizontal)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .padding(.horizontal, 5)
                        }
                        DropView(selectedItem: $viewModel.toUnit, items: ["Tonne", "Kilogram", "Gram"])
                    }
                }
                .padding(.horizontal, 350)

                // Convert, Copy, and Share Buttons
                .padding()
                HStack(spacing: 20) {
                    Button(action: {
                        viewModel.convert()
                    }) {
                        Image("ractangle")
                            .overlay {
                                Text("Convert")
                                    .foregroundColor(.yellow)
                            }
                    }

                    Button(action: {
                        viewModel.copyToClipboard()
                    }) {
                        Image("copy")
                            .resizable()
                            .frame(width: 88, height: 48)
                    }

                    Button(action: {
                        viewModel.share()
                    }) {
                        Image("share")
                            .resizable()
                            .frame(width: 88, height: 48)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden()
        } // Zstack ends
    } // Body data ends
}

#Preview {
    WeightView()
}
