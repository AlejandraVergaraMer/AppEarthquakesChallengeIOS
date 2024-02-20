//
//  MapEarthquakeView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//
import MapKit
import SwiftUI

struct CoordinatesRegion {
    let latitude: Double // = 9.9333
    let longitude: Double // = -84.0833
}

struct Span {
    let delta = 0.05
}

struct MapEarthquakeView: View {
    var coordinateRegion: CoordinatesRegion
    var span: Span
    
    @State private var region: MKCoordinateRegion
    
    init(coordinateRegion: CoordinatesRegion, span: Span) {
        self.coordinateRegion = coordinateRegion
        self.span = span
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: coordinateRegion.latitude,
                longitude: coordinateRegion.longitude),
            span: .init(latitudeDelta: span.delta, longitudeDelta: span.delta))
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
        }
    }
}

struct MapEarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        MapEarthquakeView(coordinateRegion: .init(latitude: 9.9333, longitude: -84.0833), span: .init())
    }
}
