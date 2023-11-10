//
//  SplashView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/9/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        Image("text1024")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.purple)
    }
}


struct Previews_SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
