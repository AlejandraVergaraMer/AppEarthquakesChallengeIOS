//
//  RequestModel.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 28-02-24.
//

import Foundation

public struct RequestModel {
    
    func getUrlRequest(endPoints: EventsEndpoints) -> URLRequest? {
        guard let url = endPoints.getUrl() else {
            print("URL not found")
            return nil
        }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = endPoints.method.rawValue
        for (key, value) in endPoints.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}

public enum NetworkError: Error, Equatable {
    case baseURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}

