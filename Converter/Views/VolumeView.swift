//
//  VolumeView.swift
//  Converter
//
//  Created by Arshad Mustafa on 08/12/2023.
//

// Design Volume View

import SwiftUI
import Combine

struct VolumeView: View {
    @StateObject private var viewModel = VolumeViewModel() // Get data from VolumeViewModel()

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
                Text("Volume")
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
                                .padding(.horizontal, 5)
                                .onReceive(Just(viewModel.fromValue)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.viewModel.fromValue = filtered
                                    }
                                }
                        }
                        DropView(selectedItem: $viewModel.fromUnit, items: ["Liter", "Milliliter", "Imperial Pint"])
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
                        DropView(selectedItem: $viewModel.toUnit, items: ["Liter", "Milliliter", "Imperial Pint"])
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
    } // Body ends
}

#Preview {
    VolumeView()
}
