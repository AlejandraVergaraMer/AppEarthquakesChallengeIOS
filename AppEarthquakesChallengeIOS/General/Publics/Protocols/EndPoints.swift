//
//  EndPoints.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 28-02-24.
//

import Foundation
import Combine

public protocol Requestable {
    var requestTimeOut: Float { get }
    func request<T:Codable>(_ req: RequestModel) -> AnyPublisher<T, NetworkError>
}

public enum HTTPMethod: String {

    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

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

enum EventsEndpoints: EndPoints {

    case getEarthquakeMockTwo
    case getEarthquakes(startTime: String, endTime: String)
    case getEarthquakesMock(startTime: String, endTime: String)
    case getEarthquakeDetail(id: String)
    case getEarthquakeDetailMock
    
    var requestTimeOut: Float {
        return 20
    }
    var host: String {
        switch self {
        case .getEarthquakeMockTwo, .getEarthquakesMock, .getEarthquakeDetailMock:
            return "localhost"
        case .getEarthquakes, .getEarthquakeDetail:
            return "earthquake.usgs.gov"
        }
    }
    
    var path: String {
        switch self {
        case .getEarthquakeMockTwo:
            return "/earthquakes"
        case .getEarthquakes:
            return "/fdsnws/event/1/query"
        case .getEarthquakesMock:
            return "/earthquakes/query"
        case .getEarthquakeDetail:
            return "/fdsnws/event/1/query"
        case .getEarthquakeDetailMock:
            return "/earthquakes/1"
        }
    }
    
    var parameter: [URLQueryItem] {
        switch self {
        /*case .getEarthquakeMockTwo:
            return [URLQueryItem(name: "starttime", value: "2020-01-01"), URLQueryItem(name: "endtime", value: "2020-01-02")]*/
        case .getEarthquakes(startTime: let startTime, endTime: let endTime):
            return [URLQueryItem(name: "format", value: "geojson"), URLQueryItem(name: "starttime", value: startTime), URLQueryItem(name: "endtime", value: endTime)]
        case .getEarthquakesMock(startTime: let startTime, endTime: let endTime):
            return [URLQueryItem(name: "starttime", value: startTime), URLQueryItem(name: "endtime", value: endTime)]
        case .getEarthquakeDetail(id: let id):
            return [URLQueryItem(name: "eventid", value: id), URLQueryItem(name: "format", value: "geojson")]
        default:
            return []
        }
    }
    
    var headers: [String : String] {
        switch self {
        default:
            return [:]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
