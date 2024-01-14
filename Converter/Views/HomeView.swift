//
//  HomeView.swift
//  Converter
//
//  Created by Arshad Mustafa on 08/12/2023.
//

/* Home view here . on clicking he button it will shows their screen */

import SwiftUI

struct HomeView: View {
    var body: some View { // Body code is started
        NavigationView { // Navigation start
            ZStack {
                /* Image in background */
                Image("home")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        
                        VStack {
                            HStack {
                                NavigationLink(destination: TemperatureView()) {
                                    Image("temperature")
                                        
                                }
                                NavigationLink(destination: WeightView()) {
                                    Image("weight")
                                }
                            }
                            HStack {
                                NavigationLink(destination: LengthView()) {
                                    Image("length")
                                }
                                NavigationLink(destination: TimeView()) {
                                    Image("time")
                                }
                            }
                            HStack {
                                NavigationLink(destination: PressureView()) {
                                    Image("pressure")
                                }
                                NavigationLink(destination: AreaView()) {
                                    Image("area")
                                }
                            }
                            HStack {
                                NavigationLink(destination: VolumeView()) {
                                    Image("volume")
                                }
                                NavigationLink(destination: SpeedView()) {
                                    Image("speed")
                                }
                            }
                        }
                    }
                }
            } // Zstack ends
        } // Navigation Ends
        .navigationBarBackButtonHidden()
    } // end of body code
}

#Preview {
    HomeView()
}
