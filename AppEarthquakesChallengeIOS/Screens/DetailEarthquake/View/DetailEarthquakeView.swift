//
//  DetailEarthquakeView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI

struct DetailEarthquakeView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.5), .pink.opacity(0.3), .red.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack() {
                EarthquakeLabelView(viewModel: .init(title: "Temblor gashjah hjahasj", value: "", fontSize: 24, fontWeight: .semibold))
                    .frame(alignment: .center)
                    .padding(.bottom, 30)
                MapEarthquakeView(coordinateRegion: .init(),
                                  span: .init())
                .frame(height: 400)
                .padding(.horizontal, 20)
                VStack(alignment: .leading) {
                    EarthquakeLabelView(viewModel: .init(title: "Magnitud:", value: "Temblor gashjah hjahasj", fontSize: 18, fontWeight: .medium))
                        .padding(.bottom, 10)
                    EarthquakeLabelView(viewModel: .init(title: "Profundidad:", value: "Temblor gashjah hjahasj", fontSize: 18, fontWeight: .medium))
                        .padding(.bottom, 10)
                    EarthquakeLabelView(viewModel: .init(title: "Lugar: ", value: "Temblor gashjah hjahasj", fontSize: 18, fontWeight: .medium))
                }
                Spacer()
            }
        }
    }
}

struct DetailEarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEarthquakeView()
    }
}

