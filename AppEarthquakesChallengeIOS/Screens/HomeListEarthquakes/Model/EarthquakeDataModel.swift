//
//  EarthquakeDataModel.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//
import Foundation

struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties
struct Properties: Codable {
    let mag: Double
    let place: String
    let title: String
}

struct EarthquakeDataModel: Decodable {
    let type: String
    let properties: Properties
    let geometry: Geometry
    let id: String
}

struct EarthquakeResponseDataModel: Decodable {
    let earthquakes: [EarthquakeDataModel]
    
    enum CodingKeys: String, CodingKey {
        case results = "features"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.earthquakes = try container.decode([EarthquakeDataModel].self, forKey: .results)
    }
}
