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
        VStack {
            VStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
                
                GeometryReader { geometry in
                    HStack(alignment: .bottom, spacing: 10) {
                        ForEach(0..<data.count, id: \.self) { index in
                            let barHeight = CGFloat(data[index]) / CGFloat(maxY) * geometry.size.height
                            let barWidth = (geometry.size.width - CGFloat(data.count * 10)) / CGFloat(data.count)
                            
                            VStack {
                                Rectangle()
                                    .frame(width: barWidth, height: barHeight)
                                    .foregroundColor(Color.white)
                                    .overlay(Text("\(Int(data[index]))")
                                                .font(.caption)
                                                .foregroundColor(.purple)
                                                .padding(2))
                                Text(dateFormatter.string(from: dates[index]))
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding(.bottom, 5)
        }
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
