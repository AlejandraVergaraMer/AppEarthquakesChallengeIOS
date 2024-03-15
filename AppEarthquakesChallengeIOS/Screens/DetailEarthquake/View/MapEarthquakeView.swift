//
//  MapEarthquakeView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//
import MapKit
import SwiftUI

class CoordinatesRegion: ObservableObject, Identifiable {
    let id = UUID()
    @Published var latitude: Double // = 9.9333
    @Published var longitude: Double // = -84.0833
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct Span {
    let delta = 0.1
}

struct MapEarthquakeView: View {
    @ObservedObject var coordinateRegion: CoordinatesRegion
    var span: Span
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    
    init(coordinateRegion: CoordinatesRegion, span: Span) {
        self.coordinateRegion = coordinateRegion
        self.span = span
    }
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: [coordinateRegion]) { place in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude))
            }
            .onAppear {
                setRegion()
            }
            .onChange(of: coordinateRegion.latitude) { _ in
                setRegion()
            }
            .onChange(of: coordinateRegion.longitude) { _ in
                setRegion()
            }
        }
    }
    
    func setRegion() {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: coordinateRegion.latitude,
                    longitude: coordinateRegion.longitude),
                span: .init(latitudeDelta: span.delta, longitudeDelta: span.delta))
        }
}

struct MapEarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        MapEarthquakeView(coordinateRegion: .init(latitude: 37.8455, longitude: -121.7943333), span: .init())
    }
}
