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
    //func getEarthquakeCombine(starTime: String, endTime: String) async throws -> (StatusCaseEnum, [EarthquakeModelCell]?)
    func getEarthquakeCombine(startTime: String, endTime: String) -> AnyPublisher<(StatusCaseEnum, [EarthquakeModelCell]?), Error>
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
    
    func getEarthquakeCombine(startTime: String, endTime: String) -> AnyPublisher<(StatusCaseEnum, [EarthquakeModelCell]?), Error> {
        guard let serviceApi = serviceApi else {
            return Fail(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Service API is not available"])).eraseToAnyPublisher()
        }
        
        return serviceApi.getEarthquakeListCombine(startTime: startTime, endTime: endTime)
            .map { data -> (StatusCaseEnum, [EarthquakeModelCell]?) in
                let earthquakeArray = data.earthquakes.map { earthquake -> EarthquakeModelCell in
                    let objet = EarthquakeModelCell(
                        title: earthquake.properties.title,
                        place: earthquake.properties.place,
                        magnitude: earthquake.properties.mag,
                        depth: earthquake.geometry.coordinates[2],
                        id: earthquake.id)
                    return objet
                }
                return (.success, earthquakeArray)
            }
            .eraseToAnyPublisher()
    }
    /*func getEarthquakeCombine(starTime: String, endTime: String) async throws -> (StatusCaseEnum, [EarthquakeModelCell]?) {
        guard let serviceApi = serviceApi else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Service API is not available"])
        }
        do {
            let (status, data) = try await serviceApi.getEarthquakeListCombine()
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
    }*/
    
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

//---------------MARK: FUNCIONES DE PRUEBAS-------------------------------
//func getEarthquake(completion : @escaping(_ status: StatusCaseEnum, _ data: [EarthquakeModelCell]?) -> Void)
//func getFullListCount() -> Int
//func getEarthquakeCombine() -> Future<[EarthquakeModelCell], Error>
//func getEarthquakeCombine() async throws -> [EarthquakeModelCell]
/*func getEarthquakeCombine() -> Future<[EarthquakeModelCell], Error> {
    return Future { promise in
        
        let cancellable = self.serviceApi?.getEarthquakeListCombine()
            .map({ data in
                let listEarthquake = data.earthquakes
                    .map { value in
                        EarthquakeModelCell(
                            title: value.properties.title,
                            place: value.properties.place,
                            magnitude: value.properties.mag,
                            depth: value.geometry.coordinates[2],
                            id: value.id)
                    }
                self.listOriginal = listEarthquake
                self.getNextIndices()
                promise(.success(self.listToShow))
            })
    }
}*/

/*func getEarthquakeCombine() async throws -> [EarthquakeModelCell] {
    do {
        let data = try await self.serviceApi?.getEarthquakeListCombine()
        //guard let data = data else { return }
        let listEarthquake = data?.earthquakes
            .map { value in
                EarthquakeModelCell(
                    title: value.properties.title,
                    place: value.properties.place,
                    magnitude: value.properties.mag,
                    depth: value.geometry.coordinates[2],
                    id: value.id)
            }
        self.listOriginal = listEarthquake ?? []
        self.getNextIndices()
        return self.listToShow
    } catch {
        throw error
    }
}*/

/*protocol EarthquakeListProviderProtocol {
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
}*/
