//
//  EarthquakeListProvider.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation

protocol EarthquakeListProviderProtocol {
    func getEarthquake(completion : @escaping(_ status: StatusCaseEnum, _ data: [EarthquakeModelCell]?) -> Void)
    func getNextIndices(index: Int) -> [EarthquakeModelCell]
    func getPreviousIndices(index: Int) -> [EarthquakeModelCell]
    func getFullListCount() -> Int
}

class EarthquakeListProvider: EarthquakeListProviderProtocol {
    
    var listOriginal: [EarthquakeModelCell] = []
    
    private let serviceApi: EarthquakeListServiceProtocol?

    init(serviceApi: EarthquakeListServiceProtocol) {
        self.serviceApi = serviceApi
    }
    
    func getEarthquake(completion: @escaping (StatusCaseEnum, [EarthquakeModelCell]?) -> Void) {
        serviceApi?.getEarthquakeList(completion: { status, data, error in
            guard let listEarthquake = data?.earthquakes else {
                completion(status, nil)
                return
            }
            let earthquakeArray = listEarthquake.map({ earthquake -> EarthquakeModelCell in
                let objet = EarthquakeModelCell(
                    title: earthquake.properties.title,
                    place: earthquake.properties.place,
                    magnitude: earthquake.properties.mag,
                    depth: earthquake.geometry.coordinates[2],
                    id: earthquake.id)
                return objet
            })
            self.listOriginal = earthquakeArray
            let earthquakes = self.getNextIndices(index: 0)
            completion(status, earthquakes)
        })
    }
    
    func getNextIndices(index: Int) -> [EarthquakeModelCell] {
        let starIndex = index * 10
        let endIndex = starIndex + 9
        print("StarIndex: \(starIndex), EndIndex: \(endIndex)")
        let nextList = Array(listOriginal[starIndex...endIndex])
        print(nextList)
        //let nextIndices = Array(index + 1...index + 10)
        return nextList
    }
    
    func getFullListCount() -> Int {
        return listOriginal.count
    }
    
    func getPreviousIndices(index: Int) -> [EarthquakeModelCell] {
        let starIndex = (index - 1) * 10
        let endIndex = starIndex + 9
        print("StarIndex: \(starIndex), EndIndex: \(endIndex)")
        let previousList = Array(listOriginal[starIndex...endIndex])
        print(previousList)
        //let nextIndices = Array(index + 1...index + 10)
        return previousList
    }
}
