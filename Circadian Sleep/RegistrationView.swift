//
//  RegistrationView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/9/23.
//
import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var age: Double = 16.0
    @State private var bedTime = Date()
    @AppStorage("user_name") var storedName = ""
    @AppStorage("user_age") var storedAge = 16.0
    @State private var isRegistered = false
    @State private var showError = false

    // Key for bed time in UserDefaults
    private let bedTimeKey = "user_bed_time"
    private let registrationCheckKey = "registration_check"

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.withSharedBackground()
                    .ignoresSafeArea()

                VStack {
                    Image("text1024")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding(.bottom)

                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 40)
                        .cornerRadius(15)

                    Text("Age: \(Int(age))")
                        .foregroundColor(.white)

                    Slider(value: $age, in: 16...65, step: 1)
                        .padding(.bottom)

                    Text("Bed Time:")
                        .foregroundColor(.white)

                    DatePicker("Select a time", selection: $bedTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .background(Color.gray)
                        .cornerRadius(30)
                        .padding(.bottom, 40)

                    if showError {
                        Text("Please enter a valid name")
                            .foregroundColor(.red)
                    }

                    Button("Register") {
                        if !name.isEmpty {
                            storedName = name
                            storedAge = age
                            UserDefaults.standard.set(bedTime, forKey: bedTimeKey)
                            isRegistered = true
                        } else {
                            showError = true
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(30)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
        .fullScreenCover(isPresented: $isRegistered, content: HomeView.init)
    }
}

struct Previews_RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

