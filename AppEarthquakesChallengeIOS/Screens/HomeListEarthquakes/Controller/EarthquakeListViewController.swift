//
//  EarthquakeListViewController.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation
import UIKit

class EarthquakeListViewController: UIViewController {
    
    //private var dataSource: EarthquakeTableViewDataSource?
    private let provider: EarthquakeListProviderProtocol?
    
    /*private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(picker, action: #selector(datePickerValueChanged), for: .valueChanged)
        return picker
    }()
    
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
    }()*/
    
    init(provider: EarthquakeListProviderProtocol) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
        //dataSource = EarthquakeTableViewDataSource(data: [])
        //tableView.dataSource = self.dataSource
        
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData() {
        provider?.getEarthquake(completion: { [weak self] status, data in
            guard let self = self else { return }
            switch status {
            case .success:
                //self.dataSource?.fetchData(data: data ?? [])
                //self.tableView.reloadData()
                print("error fetch data")
            case .failure:
                print("error fetch data")
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Ultimos Terremotos"
        if let navigationBar = navigationController?.navigationBar {
            let textAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 18)]
            navigationBar.titleTextAttributes = textAttributes
        }
        
        let closeButton = UIBarButtonItem(title: "Salir", style: .done, target: self, action: #selector(closeSession))
        closeButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = closeButton
        //tableView.register(cellView, forCellReuseIdentifier: "")
    }
    
    override func loadView() {
        //self.view = tableView
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Lo sentimos", message: "Hubo un error al cargar la información. Inténtalo de nuevo.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Reintentar", style: .default) { _ in
            alertController.dismiss(animated: true)
            //self.tableView.reloadData()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @objc
    private func closeSession(){
        /*SessionManager.shared.logout()
         if isItFirstLogin {
         navigationController?.setNavigationBarHidden(true, animated: false)
         navigationController?.popViewController(animated: true)
         } else {
         navigationController?.setNavigationBarHidden(true, animated: false)
         let loginController = LoginViewController()
         navigationController?.pushViewController(loginController, animated: true)
         }*/
    }
}


/*extension EarthquakeListViewController: UITableViewDelegate {
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
}*/
