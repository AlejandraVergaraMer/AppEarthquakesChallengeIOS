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
    
}
