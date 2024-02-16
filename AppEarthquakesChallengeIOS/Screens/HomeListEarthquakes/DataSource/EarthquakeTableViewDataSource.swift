//
//  EarthquakeTableViewDataSource.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 15-02-24.
//
import UIKit

class EarthquakeTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var data: [EarthquakeModelCell]
    
    init(data: [EarthquakeModelCell]) {
        self.data = data
        super.init()
    }
    
    public func fetchData(data: [EarthquakeModelCell]) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EarthquakeViewCell", for: indexPath)
        if let cellEarthquake = cell as? EarthquakeViewCell {
            let model = data[indexPath.row]
            cellEarthquake.configure(
                title: model.title,
                magnitude: model.magnitude,
                depth: model.depth,
                place: model.place)
        }
        return cell
    }
    
    func getModel(indexPath: IndexPath) -> EarthquakeModelCell{
        return data[indexPath.row]
    }
    
}
