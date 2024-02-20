//
//  EarthquakeDatePickerView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 25-01-24.
//

import Foundation
import UIKit

protocol DatePickerViewDelegate: AnyObject {
    func datePickerValueChanged()
    func didTapSearch()
}
/*
 func getEarthquake(completion : @escaping() -> Void)
 */
class EarthquakeDatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Busca por fecha"
        
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(picker, action: #selector(datePickerValueChanged), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    /*lazy var searchButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.baseForegroundColor = .black
        configuracion.baseBackgroundColor = .systemGray2
        
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchEarthquake), for: .touchUpInside)
        button.configuration = configuracion
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()*/
    
    init(delegate: DatePickerViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func datePickerValueChanged() {
        let selectedDate = datePicker.date
        // Aquí puedes aplicar la lógica de filtrado con la fecha seleccionada
        print("Fecha seleccionada: \(selectedDate)")
        delegate?.datePickerValueChanged()
    }
    
    @objc
    private func searchEarthquake() {
        delegate?.didTapSearch()
    }
    
}

extension EarthquakeDatePickerView {
    private func setupView(){
        
        self.addSubview(titleLabel)
        self.addSubview(datePicker)
        //self.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
            .init(item: datePicker, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: datePicker, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
            .init(item: datePicker, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
            
            /*.init(item: searchButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: searchButton, attribute: .leading, relatedBy: .equal, toItem: datePicker, attribute: .trailing, multiplier: 1.0, constant: 10.0),
            .init(item: searchButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
            .init(item: searchButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0),
            .init(item: searchButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0),*/
        ])
    }
}

/*
 view.addSubview(datePicker)

         // Configura las restricciones de diseño (puedes usar Auto Layout o frames)
         datePicker.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
 */
