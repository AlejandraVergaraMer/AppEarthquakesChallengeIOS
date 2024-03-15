//
//  DetailEarthquakeView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI

struct DetailEarthquakeView: View {
    
    @ObservedObject var viewModel: EarthquakeDetailViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.5), .pink.opacity(0.3), .red.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                EarthquakeLabelView(viewModel: .init(title: viewModel.data?.title ?? "", value: "", fontSize: 24, fontWeight: .semibold))
                    .frame(alignment: .center)
                    .padding(.vertical, 30)
                VStack(alignment: .leading) {
                    MapEarthquakeView(coordinateRegion: viewModel.coordinatesRegion,
                                      span: .init())
                    .frame(height: 360)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    VStack(alignment: .leading) {
                        EarthquakeLabelView(viewModel: .init(title: "Magnitud:", value: "\(String(describing: viewModel.data?.magnitude ?? 0))", fontSize: 18, fontWeight: .medium))
                            .padding(.bottom, 10)
                        EarthquakeLabelView(viewModel: .init(title: "Profundidad:", value: "\(String(describing: viewModel.data?.depth ?? 0))", fontSize: 18, fontWeight: .medium))
                            .padding(.bottom, 10)
                        EarthquakeLabelView(viewModel: .init(title: "Lugar: ", value: viewModel.data?.place ?? "", fontSize: 18, fontWeight: .medium))
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
            }
        }
    }
}

struct DetailEarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEarthquakeView(viewModel: .init())
    }
    //.init(title: "Temblor gashjah hjahasj", place: "Temblor gashjah hjahasj", magnitude: 2.5, depth: 2.6, id: "idCell", latitude: 9.9333, longitude: -84.0833)
}

