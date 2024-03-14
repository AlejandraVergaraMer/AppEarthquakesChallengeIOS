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
            }
        } catch {
            self.status = .failure
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
}
