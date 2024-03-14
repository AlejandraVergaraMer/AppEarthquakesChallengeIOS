//
//  DetailEarthquakeService.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 12-02-24.
//

import Foundation

protocol DetailEarthquakeServiceProtocol {
    func getDetail(completion : @escaping(_ status: StatusCaseEnum, _ data: EarthquakeDetailModel?, _ error: Error?) -> Void)
    func getDetailFromList(completion: @escaping(_ status: StatusCaseEnum, _ data: EarthquakeResponseDataModel?,_ idEarthquake: String, _ error: Error?) -> Void)
    func getDetailFromLisCombine() async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?)
    func getEarthquakeDetailCombine() async throws -> (StatusCaseEnum, EarthquakesDetailModel?)
}

class DetailEarthquakeService: DetailEarthquakeServiceProtocol {
    
    private var idEarthquake: String
    
    init(idEarthquake: String) {
        self.idEarthquake = idEarthquake
    }
    
    func getDetail(completion: @escaping (StatusCaseEnum, EarthquakeDetailModel?, Error?) -> Void) {
        let urlString = "http://localhost:3001/earthquakes/1"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error al obtener los datos: \(String(describing: error))")
                    completion(.failure, nil, error)
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let dataDecoder = try decoder.decode(EarthquakeDetailModel.self, from: data)
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
    
    func getDetailFromList(completion: @escaping (StatusCaseEnum, EarthquakeResponseDataModel?, String, Error?) -> Void) {
        let urlString = "http://localhost:3001/earthquakes"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error al obtener los datos: \(String(describing: error))")
                    completion(.failure, nil, self.idEarthquake, error)
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let dataDecoder = try decoder.decode(EarthquakeResponseDataModel.self, from: data)
                        completion(.success, dataDecoder, self.idEarthquake, nil)
                    } catch {
                        print("error al decodificar: \(error.localizedDescription)")
                        completion(.failure, nil, self.idEarthquake, error)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func getDetailFromLisCombine() async throws -> (StatusCaseEnum, EarthquakeResponseDataModel?) {
        let endpoint = EventsEndpoints.getEarthquakeMock
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
    
    func getEarthquakeDetailCombine() async throws -> (StatusCaseEnum, EarthquakesDetailModel?) {
        let endpoint = EventsEndpoints.getEarthquakeDetailMock(id: idEarthquake)
        let request = RequestModel()
        guard let urlRequest =  request.getUrlRequest(endPoints: endpoint) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid URLRequest"])
        }
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decoder = JSONDecoder()
        do {
            let dataDecoder = try decoder.decode(EarthquakesDetailModel.self, from: data)
            return (.success, dataDecoder)
        } catch {
            print("error al decodificar: \(error.localizedDescription)")
            throw error
        }
    }
    
}
