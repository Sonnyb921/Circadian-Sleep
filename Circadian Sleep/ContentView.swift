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
        ZStack {
            if !navigateToRegistration {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            navigateToRegistration = true
                        }
                    }
            } else {
                RegistrationView()
                    .onDisappear {
                        navigateToRegistration = false
                    }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
