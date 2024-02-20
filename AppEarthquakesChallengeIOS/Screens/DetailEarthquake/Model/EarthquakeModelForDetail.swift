//
//  EarthquakeModelForDetail.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 20-02-24.
//

import Foundation

class EarthquakeModelForDetail {
    var title: String
    var place: String
    var magnitude: Double
    var depth: Double
    let latitude: Double
    let longitude: Double
    var id: String
    
    init(title: String, place: String, magnitude: Double, depth: Double, id: String, latitude: Double, longitude: Double) {
        self.title = title
        self.place = place
        self.magnitude = magnitude
        self.depth = depth
        self.latitude = latitude
        self.longitude = longitude
        self.id = id
    }
}
