//
//  EarthquakeDetailViewModel.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 20-02-24.
//

import SwiftUI
import MapKit

class EarthquakeDetailViewModel: ObservableObject {
    @Published var status: StatusCaseEnum = .success
    @Published var data: EarthquakeModelForDetail?
    @Published var coordinatesRegion: CoordinatesRegion = CoordinatesRegion(latitude: 0.0, longitude: 0.0)
    var provider: DetailEarthquakeProvider?
    
    init(data: EarthquakeModelForDetail? = nil, provider: DetailEarthquakeProvider? = nil) {
        self.data = data
        self.provider = provider
        Task {
            await fetchDataCombine()
        }
    }

    func fetchDataCombine() async {
        do {
            guard let result = try await provider?.getDetailFromListCombine() else { return }
            guard let data = result.1 else { return }
            DispatchQueue.main.async {
                self.status = .success
                self.data = data
                self.coordinatesRegion.latitude = data.latitude
                self.coordinatesRegion.longitude = data.longitude
            }
        } catch {
            self.status = .failure
        }
    }
}
