//
//  LineGraphView.swift
//  Circadian Sleep
//
//  Created by Joshua A. Brown on 11/9/23.
//

import SwiftUI

struct LineGraph: View {
    let data: [Double]
    let title: String
    let maxY: Double
    let lineColor: Color

    var body: some View {
        ZStack {
            
            Image("background png")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            // Line graph
            VStack {
                Spacer()
                GeometryReader { geometry in
                    Path { path in
                        for (index, value) in data.enumerated() {
                            let x = CGFloat(index) / CGFloat(data.count - 1) * geometry.size.width
                            let y = geometry.size.height - (CGFloat(value) / CGFloat(maxY) * geometry.size.height)
                            if index == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .strokedPath(.init(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(30)
                    .padding()
                }
                .frame(height: 300)
                .padding(.bottom, 200)
                .cornerRadius(30)
                
               
            }
            .padding()
        }
        .navigationBarTitle(title)
    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        LineGraph(data: [7, 8, 9, 5, 10, 6, 9, 12, 7, 6, 9, 9, 8, 11, 9, 10, 7, 6, 8, 10, 12],
                  title: "Last Month's Rest", maxY: 12, lineColor: .white)
    }
}
