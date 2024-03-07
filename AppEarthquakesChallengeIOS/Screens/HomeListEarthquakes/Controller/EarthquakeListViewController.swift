//
//  EarthquakeListViewController.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation
import UIKit
import Combine

protocol EarthquakeViewControllerDelegate: AnyObject {
    func didTapDetails(idCell: String)
    func closeSession()
}

class EarthquakeListViewController: UIViewController {
    
    private let provider: EarthquakeListProviderProtocol?
    private var pagerIndex: Int = 0
    private var listData: [EarthquakeModelCell] = []
    weak var delegate: EarthquakeViewControllerDelegate?
    
    
    private lazy var datePicker: EarthquakeDatePickerView = {
        let picker = EarthquakeDatePickerView(delegate: self)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = self
        table.dataSource = self
        table.register(EarthquakeViewCell.self, forCellReuseIdentifier: "EarthquakeViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var gradientView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Fondo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init(provider: EarthquakeListProviderProtocol, delegate: EarthquakeViewControllerDelegate) {
        self.provider = provider
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        Task {
            await fetchData()
        }
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func fetchData() async {
        do {
            guard let result = try await provider?.getEarthquakeListCombine(startTime: "2020-01-01", endTime: "2020-01-02") else { return }
            guard let data = result.1 else { return }
            self.listData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            self.showAlert()
        }
        
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Lo sentimos", message: "Hubo un error al cargar la información. Inténtalo de nuevo.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Reintentar", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @objc
    private func closeSession(){
        delegate?.closeSession()
    }
}

extension EarthquakeListViewController {
    func setupView(){
        view.addSubview(gradientView)
        
        view.addSubview(datePicker)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            .init(item: gradientView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: gradientView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            .init(item: gradientView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: gradientView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            
            .init(item: datePicker, attribute: .top, relatedBy: .equal, toItem: gradientView.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: gradientView, attribute: .leading, multiplier: 1.0, constant: 0.0),
            .init(item: datePicker, attribute: .trailing, relatedBy: .equal, toItem: gradientView, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: datePicker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0),
                
            .init(item: tableView, attribute: .top, relatedBy: .equal, toItem: datePicker, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            .init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: gradientView, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: gradientView, attribute: .trailing, multiplier: 1.0, constant: -20.0),
            .init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: gradientView, attribute: .bottom, multiplier: 1.0, constant: -30.0)
            
        ])
    }
}
extension EarthquakeListViewController: DatePickerViewDelegate {
    func datePickerValueChanged() {
        //BUSCAR POR FECHA
    }
    
    func didTapSearch() {
        //BUSCAR POR FECHA
    }
}

extension EarthquakeListViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            guard let updateList = provider?.getUpdatedList() else { return }
            self.listData.append(contentsOf: updateList)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension EarthquakeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EarthquakeViewCell", for: indexPath)
        if let cell = cell as? EarthquakeViewCell {
            let model = listData[indexPath.row]
            cell.titleLabel.text = "Terremoto: \(model.title)"
            cell.magnitudeLabel.text = "Magnitud: \(model.magnitude)"
            cell.depthLabel.text = "Profundidad: \(model.depth)"
            cell.placeLabel.text = "Lugar: \(model.place)"
            cell.buttonAction = {
                self.delegate?.didTapDetails(idCell: model.id)
            }
        }
        return cell
    }
}
