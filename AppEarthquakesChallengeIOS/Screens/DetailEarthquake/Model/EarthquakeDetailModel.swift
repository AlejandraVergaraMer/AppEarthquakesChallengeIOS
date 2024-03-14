//
//  EarthquakeDetailModel.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 20-02-24.
//

import Foundation
// MARK: - EarthquakeDetailModel

struct EarthquakesDetailModel: Decodable {
    let earthquakes: EarthquakeDetailModel
    enum CodingKeys: String, CodingKey {
        case earthquakes = "properties"
    }
}
class EarthquakeDetailModel: Decodable {
    let type: String
    let properties: DetailProperties
    let geometry: Geometry
    let id: String
}


// MARK: - DetailProperties
struct DetailProperties: Codable {
    let mag: Double
    let place: String
    let time, updated: Int
    let url: String
    let status: String
    let tsunami, sig: Int
    let net, code, ids, sources: String
    let types: String
    let rms: Double
    let magType, type, title: String
    let products: Products
}

// MARK: - Products
struct Products: Codable {
    let origin, phaseData: [Origin]

    enum CodingKeys: String, CodingKey {
        case origin
        case phaseData = "phase-data"
    }
}

// MARK: - Origin
struct Origin: Codable {
    let indexid: String
    let indexTime: Int
    let id, type, code, source: String
    let updateTime: Int
    let status: String
    let properties: OriginProperties
    let preferredWeight: Int
    let contents: Contents
}

// MARK: - Contents
struct Contents: Codable {
    let contentsXML, quakemlXML: XML

    enum CodingKeys: String, CodingKey {
        case contentsXML = "contents.xml"
        case quakemlXML = "quakeml.xml"
    }
}

// MARK: - XML
struct XML: Codable {
    let contentType: String
    let lastModified, length: Int
    let url: String
    let sha256: String
}

// MARK: - OriginProperties
struct OriginProperties: Codable {
    let depth: String
    let latitude: String
    let longitude: String
}
