//
//  EventsEndpoints.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 12-03-24.
//

import Foundation

enum EventsEndpoints: EndPoints {

    case getEarthquakeMock
    case getEarthquakesParameters(startTime: String, endTime: String)
    case getEarthquakesParameterMock(startTime: String, endTime: String)
    case getEarthquakeDetail(id: String)
    case getEarthquakeDetailMock(id: String)
    
    var requestTimeOut: Float {
        return 20
    }
    var host: String {
        switch self {
        case .getEarthquakeMock, .getEarthquakesParameterMock, .getEarthquakeDetailMock:
            return "localhost"
        case .getEarthquakesParameters, .getEarthquakeDetail:
            return "earthquake.usgs.gov"
        }
    }
    
    var path: String {
        switch self {
        case .getEarthquakeMock:
            return "/fdsnws/event/1/"
        case .getEarthquakesParameters, .getEarthquakesParameterMock, .getEarthquakeDetail, .getEarthquakeDetailMock:
            return "/fdsnws/event/1/query"
        }
    }
    
    var parameter: [URLQueryItem] {
        switch self {
        case .getEarthquakesParameters(startTime: let startTime, endTime: let endTime):
            return [URLQueryItem(name: "format", value: "geojson"), URLQueryItem(name: "starttime", value: startTime), URLQueryItem(name: "endtime", value: endTime)]
        case .getEarthquakesParameterMock(startTime: let startTime, endTime: let endTime):
            return [URLQueryItem(name: "starttime", value: startTime), URLQueryItem(name: "endtime", value: endTime), URLQueryItem(name: "format", value: "geojson")]
        case .getEarthquakeDetail(id: let id):
            return [URLQueryItem(name: "eventid", value: id), URLQueryItem(name: "format", value: "geojson")]
        case .getEarthquakeDetailMock(id: let id):
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
