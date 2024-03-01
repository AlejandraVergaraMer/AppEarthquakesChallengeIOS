//
//  EarthquakeListService.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation
import Combine

protocol EarthquakeListServiceProtocol {
    func getEarthquakeList(completion : @escaping(_ status: StatusCaseEnum, _ data: EarthquakeResponseDataModel?, _ error: Error?) -> Void)
    //func getEarthquakeListCombine() -> Future<EarthquakeResponseDataModel, Error>
    //func getEarthquakeListCombine() async throws -> EarthquakeResponseDataModel
    //func getEarthquakeListCombine() async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?)
    func getEarthquakeListCombine(startTime: String?, endTime: String?) -> AnyPublisher<EarthquakeResponseDataModel, Error>
}

class EarthquakeListService: EarthquakeListServiceProtocol {
    
    var startTime: String
    var endTime: String
    
    init(startTime: String, endTime: String) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func getEarthquakeList(completion: @escaping (StatusCaseEnum, EarthquakeResponseDataModel?, Error?) -> Void) {
        
        let urlString = "http://localhost:3001/earthquakes"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error al obtener los datos: \(String(describing: error?.localizedDescription))")
                    completion(.failure, nil, error)
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
                        completion(.success, dataDecoder, nil)
                    } catch {
                        print("error al decodificar: \(error.localizedDescription)")
                        completion(.failure, nil, error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getEarthquakeListCombine(startTime: String?, endTime: String?) -> AnyPublisher<EarthquakeResponseDataModel, Error> {
        self.startTime = startTime ?? self.startTime
        self.endTime = endTime ?? self.endTime
        let endpoint = EventsEndpoints.getEarthquakesMock(startTime: self.startTime, endTime: self.endTime)
        
        return endpoint.request()
            .decode(type: EarthquakeResponseDataModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    /*func getEarthquakeListCombine() async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?) {
        
        let urlString = "http://localhost:3001/earthquakes?starttime=\(startTime)&endtime=\(endTime)"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URL"])
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        do {
            let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
            return (.success, dataDecoder)
        } catch {
            print("error al decodificar: \(error.localizedDescription)")
            throw error
        }
    }*/
}
/*func getEarthquakeListCombine() async throws -> EarthquakeResponseDataModel {
    let urlString = "http://localhost:3001/earthquakes"
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
    return dataDecoder
}*/
/*func getEarthquakeListCombine() -> Future<EarthquakeResponseDataModel, Error> {
    return Future { promise in
        let urlString = "http://localhost:3001/earthquakes"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error al obtener los datos: \(String(describing: error?.localizedDescription))")
                    //completion(.failure, nil, error)
                    promise(.failure(error!))
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
                        promise(.success(dataDecoder))
                        //completion(.success, dataDecoder, nil)
                    } catch {
                        print("error al decodificar: \(error.localizedDescription)")
                        promise(.failure(error))
                        //completion(.failure, nil, error)
                    }
                    
                }
            }
            task.resume()
        }
    }
}*/

/*
 protocol EarthquakeListServiceProtocol {
     func getEarthquakeList(completion : @escaping(_ status: StatusCaseEnum, _ data: EarthquakeResponseDataModel?, _ error: Error?) -> Void)
 }

 class EarthquakeListService: EarthquakeListServiceProtocol {
     
     var startTime: String
     var endTime: String
     
     init(startTime: String, endTime: String) {
         self.startTime = startTime
         self.endTime = endTime
     }
     
     func getEarthquakeList(completion: @escaping (StatusCaseEnum, EarthquakeResponseDataModel?, Error?) -> Void) {
         
         let urlString = "http://localhost:3001/earthquakes"
         if let url = URL(string: urlString) {
             let session = URLSession(configuration: .default)
             
             let task = session.dataTask(with: url) { data, response, error in
                 if error != nil {
                     print("Error al obtener los datos: \(String(describing: error?.localizedDescription))")
                     completion(.failure, nil, error)
                 }
                 if let data = data {
                     let decoder = JSONDecoder()
                     do {
                         let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
                         completion(.success, dataDecoder, nil)
                     } catch {
                         print("error al decodificar: \(error.localizedDescription)")
                         completion(.failure, nil, error)
                     }
                     
                 }
             }
             task.resume()
         }
     }
 }
 */

/*guard let url = URL(string: "http://localhost:3001/earthquakes") else { return }

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data = data else { return }
    let dataModel = try! JSONDecoder().decode(EarthquakeResponseDataModel.self, from: data)
    //print("dataModel \(dataModel)")
    completion(.success, dataModel, nil)
}
task.resume()
 
 /*let dataModel = try! JSONDecoder().decode(EarthquakeResponseDataModel.self, from: data)*/
 
 if let data = try? Data(contentsOf: url) {
     let decoder = JSONDecoder()
     if let dataDecoder = try?  decoder.decode(EarthquakeResponseDataModel.self, from: data) {
         completion(.success, dataDecoder, nil)
     } else {
         completion(.failure, nil, nil)
     }
 }
 
 */

/*

     func getEarthquakeList(completion: @escaping(StatusCaseEnum, EarthquakesListModel?, Error?) -> Void) {
         
         AF.request(ApiRouterUrl.getEarthquakes(startTime: startTime, endTime: endTime)).response { response in

             switch response.result {
             case .success(let data):
                 guard let data = data else { return }
                 do {
                     let result = try JSONDecoder().decode(EarthquakesListModel.self, from: data)
                     completion(.success, result, nil)
                 }  catch let errorCatch {
                     completion(.failure, nil, errorCatch)
                 }
             case .failure(_):
                 if let url = Bundle.main.url(forResource: "earthquake-query", withExtension: "json") {
                     do {
                         let data = try Data(contentsOf: url)
                         let decoder = JSONDecoder()
                         let jsonData = try decoder.decode(EarthquakesListModel.self, from: data)
                         completion(.success, jsonData, nil)
                     } catch {
                         print("error:\(error)")
                         completion(.failure, nil, error)
                     }
 */


/*
 {
     "request": {
         "url": "/earthquakes",
         "method": "GET",
         "headers": { },
         "bodyPatterns": [
             //{ "matchesJsonPath" : "[?(@.user == '22222222-2')]" }
         ]
     },
     "response": {
         "status": 200,
         "fixedDelayMilliseconds": 300,
         "headers": {
             "Content-Type": "application/json"
         },
         "jsonBody": {
             "type": "FeatureCollection",
             "metadata": {
                 "generated": 1701087784000,
                 "url": "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2020-01-01&endtime=2020-01-02",
                 "title": "USGS Earthquakes",
                 "status": 200,
                 "api": "1.14.0",
                 "count": 611
             },
             "features": [],
            "bbox": [
                -179.2752,
                -53.0907,
                -1.75,
                175.8577,
                69.6006,
                392.48
            ]
        }
    }
}
 */
