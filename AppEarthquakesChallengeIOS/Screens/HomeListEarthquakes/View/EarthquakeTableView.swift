//
//  EarthquakeTableView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 25-01-24.
//

import Foundation
import UIKit

/*protocol EarthquakeTableViewDelegate: AnyObject {
    func didTapDetails(idCell: String)
    func didTapNextPage()
    func didTapPreciousPage()
}*/

/*class EarthquakeTableView: UIView {

    //public var dataSource: EarthquakeTableViewDataSource?
    weak var delegate: EarthquakeTableViewDelegate?
    public var data: [EarthquakeModelCell] =  [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.register(EarthquakeViewCell.self, forCellReuseIdentifier: "EarthquakeViewCell")
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var pagerView: EarthquakePagerView = {
        let pager = EarthquakePagerView(delegate: self)
        pager.translatesAutoresizingMaskIntoConstraints = false
                
        return pager
    }()
    
    init(delegate: EarthquakeTableViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        //dataSource = EarthquakeTableViewDataSource()
        
        self.backgroundColor = .clear
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EarthquakeTableView {
    private func setupView(){
        
        self.addSubview(tableView)
        self.addSubview(pagerView)
        
        NSLayoutConstraint.activate([
            
            .init(item: tableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
            .init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            
            .init(item: pagerView, attribute: .top, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1.0, constant: 20.0),
            .init(item: pagerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            .init(item: pagerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0),
            .init(item: pagerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0),
        ])
    }
}

extension EarthquakeTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = data[indexPath.row]
        
        let idCell = selected.id
        delegate?.didTapDetails(idCell: idCell)
    }
}

extension EarthquakeTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
}

extension EarthquakeTableView: EarthquakePagerViewDelegate {
    func didTapNextPage() {
        delegate?.didTapNextPage()
    }
    
    func didTapPreciousPage() {
        delegate?.didTapPreciousPage()
    }
    
    
}*/
