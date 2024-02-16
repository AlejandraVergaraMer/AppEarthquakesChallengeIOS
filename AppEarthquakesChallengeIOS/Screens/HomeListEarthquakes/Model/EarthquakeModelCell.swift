//
//  EarthquakeModelCell.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation

class EarthquakeModelCell {
    var title: String
    var place: String
    var magnitude: Double
    var depth: Double
    var id: String
    
    init(title: String, place: String, magnitude: Double, depth: Double, id: String) {
        self.title = title
        self.place = place
        self.magnitude = magnitude
        self.depth = depth
        self.id = id
    }
}
