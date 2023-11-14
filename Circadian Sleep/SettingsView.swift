//
//  SettingsView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/9/23.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("soundEnabled") private var soundEnabled = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications").foregroundColor(.purple)) {
                    Toggle("Receive Notifications", isOn: $notificationsEnabled)
                }

                Section(header: Text("Sound").foregroundColor(.purple)) {
                    Toggle("Enable Sound", isOn: $soundEnabled)
                }
            }
            
            .navigationBarTitle("Settings", displayMode: .inline)
        }
        .background(Color.clear.withSharedBackground())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
