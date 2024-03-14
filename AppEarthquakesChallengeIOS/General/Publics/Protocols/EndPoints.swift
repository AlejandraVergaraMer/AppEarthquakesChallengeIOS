//
//  EndPoints.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 28-02-24.
//

import Foundation
import Combine

public protocol EndPoints {
    var host: String { get }
    var path: String { get }
    var parameter: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    
    func getUrl() -> URL?
}

extension EndPoints {
    func getUrl() -> URL? {
        var component = URLComponents()
        component.scheme = "http"
        component.host = host
        component.path = path
        component.port = 3001
        component.queryItems = parameter
        return component.url
    }
}
