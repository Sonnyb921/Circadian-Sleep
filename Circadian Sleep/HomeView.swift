//
//  HomeView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/9/23.
//
import SwiftUI

struct HomeView: View {
    @State private var currentTime = Date()
    @AppStorage("bed_time") var storedBedTime: String = UserDefaults.standard.string(forKey: "user_bed_time") ?? "10:00 PM"
    @State private var sleepTime = Date()
    @State private var wakeTime = Date()
    @State private var loggedRestHours: Double = 0.0
    @State private var showError = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("background png")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                // Clock format
                VStack {
                    Text(currentTimeFormatted)
                        .font(.system(size: 85))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 100)

                    Spacer()

                    HStack {
                        VStack {
                            Text("Sleep Time:")
                                .font(.headline)
                                .foregroundColor(.black)

                            DatePicker("Select a time", selection: $sleepTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .background(Color.gray)
                                .cornerRadius(10)

                        } .padding(.trailing, 40)


                        VStack {
                            Text("Wake Time:")
                                .font(.headline)
                                .foregroundColor(.black)

                            DatePicker("Select a time", selection: $wakeTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .background(Color.gray)
                                .cornerRadius(10)
                        } .padding(.leading, 40)
                    } .padding(.bottom, 90)

                    Button("Log Rest") {
                        if !hasAlreadyLoggedRest() {
                            let components = Calendar.current.dateComponents([.hour, .minute], from: sleepTime, to: wakeTime)
                            _ = Double(components.hour ?? 0) + Double(components.minute ?? 0) / 60
                            calculateAndLogRestHours()
                        } else {
                            showError = true
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(10)

                    Spacer()

                    if showError {
                        Text("You have already logged rest today.")
                            .foregroundColor(.red)
                    }

                    HStack {
                        NavigationLink(destination: ChartsView()) {
                            NavigationButton(iconName: "chart.bar.xaxis", label: "Charts")
                                .foregroundColor(.white)
                                .padding(.trailing, 25)
                        }

                        NavigationLink(destination: SettingsView()) {
                            NavigationButton(iconName: "gearshape", label: "Settings")
                                .foregroundColor(.white)
                                .padding(25)
                        }
                        NavigationLink(destination: SoundsView()) {
                            NavigationButton(iconName: "music.note.list", label: "Sounds")
                                .foregroundColor(.white)
                                .padding(.leading, 25)
                        }

                    }
                    .padding(.horizontal, 20)
                }
            }
            .onAppear {
                let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    currentTime = Date()
                }
                RunLoop.current.add(timer, forMode: .common)
            }
        }
    }

    var currentTimeFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: currentTime)
    }

    func hasAlreadyLoggedRest() -> Bool {
        let currentDate = Date()
        let lastLoggedRestDate = UserDefaults.standard.object(forKey: "last_logged_rest_date") as? Date

        if let lastDate = lastLoggedRestDate, Calendar.current.isDate(currentDate, inSameDayAs: lastDate) {
            return true
        }

        return false
    }

    func calculateAndLogRestHours() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: sleepTime, to: wakeTime)
        let hoursSlept = Double(components.hour ?? 0) + Double(components.minute ?? 0) / 60

        let currentDate = Date()
        let lastLoggedRestDate = UserDefaults.standard.object(forKey: "last_logged_rest_date") as? Date

        if lastLoggedRestDate != nil {
            let calendar = Calendar.current
            if calendar.isDate(currentDate, inSameDayAs: lastLoggedRestDate!) {
                print("Rest has already been logged today.")
            } else {
                // Log the rest
                loggedRestHours = hoursSlept
                UserDefaults.standard.set(currentDate, forKey: "last_logged_rest_date")
            }
        } else {
            // Log the rest for the first time
            loggedRestHours = hoursSlept
            UserDefaults.standard.set(currentDate, forKey: "last_logged_rest_date")
        }
    }
}

struct NavigationButton: View {
    let iconName: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 30, height: 30)
            Text(label)
                .font(.footnote)
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

