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
    func getEarthquakeListCombine() async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?)
    func getEarthquakesCombine(startTime: String, endTime: String) async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?)
    //func getEarthquakeListCombine(startTime: String, endTime: String) -> AnyPublisher<EarthquakeResponseDataModel, NetworkError>
}

class EarthquakeListService: EarthquakeListServiceProtocol {

    //var startTime: String
    //var endTime: String
    //private var networkRequest: Requestable
    
    /*init(startTime: String, endTime: String) {
        self.startTime = startTime
        self.endTime = endTime
        //self.networkRequest = networkRequest
    }*/
    init() {
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
    
    func getEarthquakeListCombine() async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?) {
        
        /*let urlString = "http://localhost:3001/earthquakes"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URL"])
        }*/
        let endpoint = EventsEndpoints.getEarthquakeMockTwo
        /*guard let url = endpoint.getUrl() else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URL"])
            }*/
        let request = RequestModel()
        guard let urlRequest =  request.getUrlRequest(endPoints: endpoint) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URLRequest"])
        }//URLRequest(url: url)
        //urlRequest.httpMethod = endpoint.method.rawValue
        //urlRequest.allHTTPHeaderFields = endpoint.headers
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        do {
            let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
            return (.success, dataDecoder)
        } catch {
            print("error al decodificar: \(error.localizedDescription)")
            throw error
        }
    }
    
    func getEarthquakesCombine(startTime: String, endTime: String) async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?) {
        let endpoint = EventsEndpoints.getEarthquakesMock(startTime: startTime, endTime: endTime)
        let request = RequestModel()
        guard let urlRequest =  request.getUrlRequest(endPoints: endpoint) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URLRequest"])
        }
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        do {
            let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
            return (.success, dataDecoder)
        } catch {
            print("error al decodificar: \(error.localizedDescription)")
            throw error
        }
    }
    
    /*func getEarthquakeListCombine(startTime: String, endTime: String) -> AnyPublisher<EarthquakeResponseDataModel, NetworkError> {
        let eventEndPoint = EventsEndpoints.getEarthquakesMock(startTime: startTime, endTime: endTime)
        let request = RequestModel()
        guard let urlRequest =  request.getUrlRequest(endPoints: eventEndPoint) else {
            //throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URLRequest"])
        }
        //let request = RequestModel(endPoints: eventEndPoint, reqTimeOut: 30)
        return self.networkRequest.request(request)
    }*/
     
}

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
