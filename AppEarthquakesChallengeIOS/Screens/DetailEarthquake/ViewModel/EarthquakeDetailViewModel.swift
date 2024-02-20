//
//  EarthquakeDetailViewModel.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 20-02-24.
//

import SwiftUI

class EarthquakeDetailViewModel: ObservableObject {
    @Published var status: StatusCaseEnum = .success
    @Published var data: EarthquakeModelForDetail?
    var provider: DetailEarthquakeProvider?
    
    init(data: EarthquakeModelForDetail? = nil, provider: DetailEarthquakeProvider? = nil) {
        self.data = data
        self.provider = provider
        
        fetchData()
    }

    func fetchData() {
        provider?.getDetailFromList(completion: { status, data, error in
            if let data = data {
                self.status = .success
                self.data = data
            } else {
                self.status = .failure
            }
        })
    }
}
