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

struct EarthquakeDataModel: Decodable, Encodable {
    let type: String
    let properties: Properties
    let geometry: Geometry
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case type, properties, geometry, id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(properties, forKey: .properties)
        try container.encode(geometry, forKey: .geometry)
        try container.encode(id, forKey: .id)
    }
}

struct EarthquakeResponseDataModel: Decodable, Encodable {
    let earthquakes: [EarthquakeDataModel]
    
    enum CodingKeys: String, CodingKey {
        case results = "features"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.earthquakes = try container.decode([EarthquakeDataModel].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(earthquakes, forKey: .results)
    }
}
