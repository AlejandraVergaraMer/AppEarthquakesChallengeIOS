//
//  EarthquakeListService.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation

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
        guard let url = URL(string: "http://localhost:3001/earthquakes") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let dataModel = try! JSONDecoder().decode(EarthquakeResponseDataModel.self, from: data)
            print("dataModel \(dataModel)")
            completion(.success, dataModel, nil)
        }
        task.resume()
    }
}

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
