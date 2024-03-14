//
//  EarthquakeListProvider.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation
import Combine

protocol EarthquakeListProviderProtocol {
    func getNextIndices()
    func getUpdatedList() -> [EarthquakeModelCell]
    func getEarthquakeListCombine(startTime: String, endTime: String) async throws -> (StatusCaseEnum, [EarthquakeModelCell]?)
}

class EarthquakeListProvider: EarthquakeListProviderProtocol {
    
    private var listOriginal: [EarthquakeModelCell] = []
    private var listToShow: [EarthquakeModelCell] = []
    
    private let serviceApi: EarthquakeListServiceProtocol?
    private var index: Int = 0
    
    var cancellables = Set<AnyCancellable>()

    init(serviceApi: EarthquakeListServiceProtocol) {
        self.serviceApi = serviceApi
    }
    
    func getEarthquakeListCombine(startTime: String, endTime: String) async throws -> (StatusCaseEnum, [EarthquakeModelCell]?) {
        guard let serviceApi = serviceApi else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Service API is not available"])
        }
        do {
            let (status, data) = try await serviceApi.getEarthquakesCombine(startTime: startTime, endTime: endTime)
            guard status == .success, let listEarthquake = data?.earthquakes else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "No data available"])
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
            self.getNextIndices()
            return (StatusCaseEnum.success, self.listToShow)
        } catch {
            throw error
        }
    }
    
    func getNextIndices(){
        let starIndex = index * 10
        let endIndex = starIndex + 9
        let nextList = Array(listOriginal[starIndex...endIndex])
        //self.listToShow.append(contentsOf: nextList)
        self.listToShow = nextList
        self.index += 1
    }
    
    func getUpdatedList() -> [EarthquakeModelCell] {
        getNextIndices()
        return listToShow
    }
}
//---------------MARK: PROVIDER CON COMPLETION HANDLER---------------------
//Descomentar este codigo y comentar Provider Combine para revisar.
/*
 protocol EarthquakeListProviderProtocol {
     func getEarthquake(completion : @escaping(_ status: StatusCaseEnum, _ data: [EarthquakeModelCell]?) -> Void)
     func getNextIndices()
     func getUpdatedList() -> [EarthquakeModelCell]
 }

 class EarthquakeListProvider: EarthquakeListProviderProtocol {
     
     private var listOriginal: [EarthquakeModelCell] = []
     private var listToShow: [EarthquakeModelCell] = []
     
     private let serviceApi: EarthquakeListServiceProtocol?
     private var index: Int = 0

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
             self.getNextIndices()
             completion(status, self.listToShow)
         })
     }
     
     func getNextIndices(){
         let starIndex = index * 10
         let endIndex = starIndex + 9
         let nextList = Array(listOriginal[starIndex...endIndex])
         //self.listToShow.append(contentsOf: nextList)
         self.listToShow = nextList
         self.index += 1
     }
     //print("StarIndex: \(starIndex), EndIndex: \(endIndex)")
     //print(nextList)
     //let nextIndices = Array(index + 1...index + 10)
     //listToShow = nextList
     
     func getUpdatedList() -> [EarthquakeModelCell] {
         getNextIndices()
         return listToShow
     }
 }
 */
