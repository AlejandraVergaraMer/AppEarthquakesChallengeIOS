//
//  EarthquakeListProvider.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation

protocol EarthquakeListProviderProtocol {
    func getEarthquake(completion : @escaping(_ status: StatusCaseEnum, _ data: [EarthquakeModelCell]?) -> Void)
}

class EarthquakeListProvider: EarthquakeListProviderProtocol {
    private let serviceApi: EarthquakeListServiceProtocol?

    init(serviceApi: EarthquakeListServiceProtocol) {
        self.serviceApi = serviceApi
    }
    
    func getEarthquake(completion: @escaping (StatusCaseEnum, [EarthquakeModelCell]?) -> Void) {
        serviceApi?.getEarthquakeList(completion: { status, data, error in
            let apiListEarthquake = data?.earthquakes
            let earthquakeArray = apiListEarthquake?.map({ earthquake -> EarthquakeModelCell in
                let objet = EarthquakeModelCell(
                    title: earthquake.properties.title,
                    place: earthquake.properties.place,
                    magnitude: earthquake.properties.mag,
                    depth: earthquake.geometry.coordinates[2],
                    id: earthquake.id)
                return objet
            })
            completion(status, earthquakeArray ?? nil)
        })
    }

    /*func getEarthquake(completion: @escaping(StatusCaseEnum, [EarthquakeModelCell]?) -> Void) {
        serviceApi?.getEarthquakeList(completion: { status, data, error in
            let apiListEarthquake = data?.earthquakes
            let earthquakeArray = apiListEarthquake?.map({ earthquake -> EarthquakeModelCell in
                let objet = EarthquakeModelCell(
                    title: earthquake.properties.title,
                    place: earthquake.properties.place,
                    magnitude: earthquake.properties.mag,
                    depth: earthquake.geometry.coordinates[2],
                    id: earthquake.id)
                return objet
            })
            completion(status, earthquakeArray ?? nil)
        })
    }*/
}
