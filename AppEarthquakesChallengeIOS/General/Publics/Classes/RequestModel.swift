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
    /*let endPoints: EndPoints
    let body: Data?
    let requestTimeOut: Float?
    
    public init(endPoints: EndPoints,
                reqBody: Encodable? = nil,
                reqTimeOut: Float? = nil) {
        self.endPoints = endPoints
        self.requestTimeOut = reqTimeOut
        /*if let reqBody = reqBody {
            self.body = reqBody.encode(to: <#T##Encoder#>)
        }*/
        var setBody: Data?
        if let reqBody = reqBody {
            do {
                let encoder = JSONEncoder()
                setBody = try encoder.encode(reqBody)
            } catch {
                print("Error encoding reqBody: \(error)")
                // Maneja el error según tus requerimientos
            }
        }
        self.body = setBody
    }
    
    public init(endPoints: EndPoints,
                reqBody: Data? = nil,
                reqTimeOut: Float? = nil) {
        self.endPoints = endPoints
        self.body = reqBody
        self.requestTimeOut = reqTimeOut
    }
    
    func getUrlRequest() -> URLRequest? {
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
    }*/
}


/*public class NetworkRequestable: Requestable {
    public var requestTimeOut: Float = 30
    
    public func request<T>(_ req: RequestModel) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        return URLSession.shared
            .dataTaskPublisher(for: req.getUrlRequest()!)
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}*/

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

