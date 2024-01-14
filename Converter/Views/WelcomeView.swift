//
//  WelcomeView.swift
//  Converter
//
//  Created by Arshad Mustafa on 08/12/2023.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showHomeView = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("launch")
                    .resizable()
                    .ignoresSafeArea()

                if showHomeView {
                    NavigationLink("", destination: HomeView(), isActive: $showHomeView)
                        .hidden()
                }
            }
            .onAppear {
                /* screen shows only for 2 sec and automatically Disappear after 2 sec */
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showHomeView = true
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
