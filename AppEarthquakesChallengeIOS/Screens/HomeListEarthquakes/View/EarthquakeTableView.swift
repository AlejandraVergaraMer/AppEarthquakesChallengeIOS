//
//  EarthquakeTableView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 25-01-24.
//

import Foundation
import UIKit

class EarthquakeTableView: UIView, UITableViewDelegate {

    private var dataSource: EarthquakeTableViewDataSource?
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.register(EarthquakeViewCell.self, forCellReuseIdentifier: "EarthquakeViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var nextPageButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.title = ">"
        configuracion.titleAlignment = .center
        configuracion.baseForegroundColor = .black
        configuracion.baseBackgroundColor = .systemGray2
                        
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.configuration = configuracion
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    lazy var previousPageButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.title = "<"
        configuracion.titleAlignment = .center
        configuracion.baseForegroundColor = .black
        configuracion.baseBackgroundColor = .systemGray2
                        
        button.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        button.configuration = configuracion
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        dataSource = EarthquakeTableViewDataSource(data: [])
        tableView.dataSource = self.dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func nextPage() {
        
    }
    
    @objc
    private func previousPage() {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selected = dataSource?.getModel(indexPath: indexPath) else { return }
        let idCell = selected.id
        //MARK: LLAMAR A CONTROLADOR DE DETAILS
        /*let service = DetailEarthquakeService(idEarthquake: idCell)
         let provider = DetailEarthquakeProvider(serviceApi: service)
         let controller = DetailEarthquakeViewController(providerDetails: provider, viewModel: selected)*/
        //let controller = UIHostingController(rootView: EarthquakeViewCell())
        //navigationController?.pushViewController(controller, animated: true)
    }
}
