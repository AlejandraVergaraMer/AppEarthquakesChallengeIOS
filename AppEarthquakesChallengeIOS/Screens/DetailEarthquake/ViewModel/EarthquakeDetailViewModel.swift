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
        
        //fetchDataCompletion()
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
/*func fetchDataCompletion() {
    provider?.getDetailFromList(completion: { status, data, error in
        DispatchQueue.main.async {
            if let data = data {
                self.status = .success
                self.data = data
            } else {
                self.status = .failure
            }
        }
    })
}*/
/*var title: String {
    guard let title = data?.title else { return ""}
    return title
}

var latitude: Double {
    guard let latitude = data?.latitude else { return 0.000}
    return latitude
}

var longitude: Double {
    guard let longitude = data?.longitude else { return 0.000}
    return longitude
}

var magnitude: Double {
    guard let magnitude = data?.magnitude else { return 0.000}
    return magnitude
}

var depth: Double {
    guard let depth = data?.depth else { return 0.000}
    return depth
}

var place: String {
    guard let place = data?.place else { return ""}
    return place
}*/
