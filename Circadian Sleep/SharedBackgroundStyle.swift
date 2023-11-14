//
//  SharedBackgroundStyle.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/13/23.
//

import SwiftUI

struct SharedBackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Image("background png")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

extension View {
    func withSharedBackground() -> some View {
        self.modifier(SharedBackgroundStyle())
    }
}
