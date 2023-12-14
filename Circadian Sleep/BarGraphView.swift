//
//  BarGraphView.swift

import SwiftUI

struct BarGraph: View {
    let data: [Double]
    let dates: [Date]
    let title: String
    let maxY: Double
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: Text(title)) { // Replace Text(title) with actual destination view
         
                
                VStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    GeometryReader { geometry in
                        HStack(alignment: .bottom, spacing: 10) {
                            ForEach(0..<data.count, id: \.self) { index in
                                let barHeight = CGFloat(data[index]) / CGFloat(maxY) * geometry.size.height
                                let barWidth = (geometry.size.width - CGFloat(data.count * 10)) / CGFloat(data.count)
                                
                                VStack {
                                    Rectangle()
                                        .frame(width: barWidth, height: barHeight)
                                        .foregroundColor(.white) // Change to desired bar color
                                        .cornerRadius(8)
                                        .overlay(Text("\(Int(data[index]))")
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                                    .padding(2))
                                    Text(dateFormatter.string(from: dates[index]))
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(.bottom, 20)
                }
                .padding()
            }
            .navigationBarHidden(true) // Hide navigation bar
        }
    
}




struct BarGraph_Previews: PreviewProvider {
    static var previews: some View {
        let data: [Double] = [7, 5, 9, 12, 10, 8, 7, 9]
        let dates: [Date] = [Date(), Date(), Date(), Date(), Date(), Date(), Date(), Date()]
        return BarGraph(data: data, dates: dates, title: "Last 7 Days Rest", maxY: 12)
            .frame(height: 200)
            .padding()
    }
}
