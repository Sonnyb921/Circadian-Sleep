//
//  ChartsView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/9/23.
//
import SwiftUI

struct ChartsView: View {
    @State private var last30DaysData: [Double] = [7, 8, 9, 5, 10, 6, 9, 12, 7, 6, 9, 9, 8, 11, 9, 10, 7, 6, 8, 10, 12, 8, 9, 10, 9, 6, 9, 12, 7, 12]
    @State private var last7DaysData: [Double] = [6.5, 8.5, 7.0, 12.0, 11.0, 5.5, ]

    // Sample dates: 11/05-11/12
    private let sampleDates: [Date] = [
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 5))!,
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 6))!,
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 7))!,
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 8))!,
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 9))!,
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 10))!,
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 11))!,
        Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 12))!
    ]

    func averageSleepPerNight(data: [Double]) -> Double {
        guard !data.isEmpty else { return 0 }
        let totalHours = data.reduce(0, +)
        return totalHours / Double(data.count)
    }

    var averageLast7DaysSleep: Double {
        return averageSleepPerNight(data: last7DaysData)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.withSharedBackground()

                VStack {
                    Text("REST RECAP")
                        .font(.system(size: 52, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.bottom, 80)
                        .navigationBarBackButtonHidden(true)

                    BarGraph(data: last7DaysData, dates: sampleDates, title: "Last Week's Rest", maxY: 12)
                        .frame(height: 300)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(30)

                    Text("Average Nightly: \(averageLast7DaysSleep, specifier: "%.1f") hours")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(10)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        NavigationLink(destination: HomeView()) {
                            NavigationButton(iconName: "house", label: "Home")
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
                        .navigationBarBackButtonHidden(true)
                    }
                    .padding()
                }
            }
            .onAppear {
                // Example: Update data with 7 hours slept when the view appears
                updateSleepData(hoursSlept: 7.0)
            }
        }
    }

    // Create a function to update the data when the user logs rest
    func updateSleepData(hoursSlept: Double) {
        _ = Date()
        last30DaysData.append(hoursSlept)
        last7DaysData.append(hoursSlept)

        // Limit data to the last 30 days
        if last30DaysData.count > 30 {
            last30DaysData.removeFirst()
        }

        // Limit data to the last 7 days
        if last7DaysData.count > 7 {
            last7DaysData.removeFirst()
        }

        // Example: Print the updated data
        print("Last 30 Days Data: \(last30DaysData)")
        print("Last 7 Days Data: \(last7DaysData)")
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}



