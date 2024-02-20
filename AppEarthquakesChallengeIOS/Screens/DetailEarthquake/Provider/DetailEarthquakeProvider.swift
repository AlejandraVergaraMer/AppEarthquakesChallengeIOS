//
//  DetailEarthquakeProvider.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 20-02-24.
//

import Foundation

protocol DetailEarthquakeProviderProtocol {
    func getDetail(completion: @escaping(_ status: StatusCaseEnum, _ data: EarthquakeModelForDetail) -> Void)
    func getDetailFromList(completion: @escaping(_ status: StatusCaseEnum, _ data: EarthquakeModelForDetail?, _ error: Error?) -> Void)
}

class DetailEarthquakeProvider: DetailEarthquakeProviderProtocol {
    
    private let serviceApi: DetailEarthquakeServiceProtocol?
    
    init(serviceApi: DetailEarthquakeServiceProtocol?) {
        self.serviceApi = serviceApi
    }
    
    func getDetail(completion: @escaping (StatusCaseEnum, EarthquakeModelForDetail) -> Void) {
        serviceApi?.getDetail(completion: { status, data, error in
            let details = data.map { dataDetails -> EarthquakeModelForDetail in
                let detail = dataDetails.properties
                let object = EarthquakeModelForDetail(
                    title: detail.title,
                    place: detail.place,
                    magnitude: detail.mag,
                    depth: dataDetails.geometry.coordinates[2],
                    id: dataDetails.id,
                    latitude: dataDetails.geometry.coordinates[1],
                    longitude: dataDetails.geometry.coordinates[0])
                return object
            }
            guard let dataDetail = details else { return }
            completion(status, dataDetail)
        })
    }
    
    func getDetailFromList(completion: @escaping (StatusCaseEnum, EarthquakeModelForDetail?, Error?) -> Void) {
        serviceApi?.getDetailFromList(completion: { status, data, id, error in
            guard let listEarthquake = data?.earthquakes else {
                completion(status, nil, error)
                return
            }
            listEarthquake.forEach { earthquake in
                if earthquake.id == id {
                    let object = EarthquakeModelForDetail(
                        title: earthquake.properties.title,
                        place: earthquake.properties.place,
                        magnitude: earthquake.properties.mag,
                        depth: earthquake.geometry.coordinates[2],
                        id: earthquake.id,
                        latitude: earthquake.geometry.coordinates[1],
                        longitude: earthquake.geometry.coordinates[0])
                    completion(status, object, nil)
                }
            }
            
        })
    }

}

/*let earthquakeArray = listEarthquake.map({ earthquake -> EarthquakeModelForDetail in
    let objet = EarthquakeModelForDetail(
        title: earthquake.properties.title,
        place: earthquake.properties.place,
        magnitude: earthquake.properties.mag,
        depth: earthquake.geometry.coordinates[2],
        id: earthquake.id,
        latitude: earthquake.geometry.coordinates[1],
        longitude: earthquake.geometry.coordinates[0])
    if earthquake.id == id {
        return objet
    }
})*/
/*self.listOriginal = earthquakeArray
let earthquakes = self.getNextIndices(index: 0)//earthquakeArray.prefix(10)
completion(status, earthquakes)*/
   
/*(
    title: earthquake.properties.title,
    place: earthquake.properties.place,
    magnitude: earthquake.properties.mag,
    depth: earthquake.geometry.coordinates[2],
    id: earthquake.id)*/

/*let object = EarthquakeModelForDetail(
    title: detail.title,
    place: detail.place,
    magnitude: detail.mag,
    depth: dataDetails.geometry.coordinates[2],
    latitude: d
    id: dataDetails.id)*/
