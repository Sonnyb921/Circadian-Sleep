//
//  ContentView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToRegistration = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if !navigateToRegistration {
                    SplashScreenView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                navigateToRegistration = true
                            }
                        }
                } else {
                    NavigationLink(
                        destination: RegistrationView(),
                        isActive: $navigateToRegistration
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
