//
//  EarthquakeDatePickerView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 25-01-24.
//

import Foundation
import UIKit

protocol DatePickerViewDelegate: AnyObject {
    func didTapSearch(startTime: String, endTime: String)
}

class EarthquakeDatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    
    private let datePickersContetView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.spacing = 4.0
        view.distribution = .fillProportionally
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(startDatePickerValueChanged), for: .valueChanged)
        picker.date = DateManager.getPreviousDate()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.widthAnchor.constraint(equalToConstant: 128.0).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 26.0).isActive = true
        return picker
    }()
    
    private let endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(endDatePickerValueChanged), for: .valueChanged)
        picker.date = DateManager.getCurrentDate()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.widthAnchor.constraint(equalToConstant: 128.0).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 26.0).isActive = true
        return picker
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.baseForegroundColor = .black
        configuracion.baseBackgroundColor = .systemGray2
        configuracion.title = "Buscar"
        let originalImage = UIImage(systemName: "magnifyingglass")
        let newSize = CGSize(width: 16, height: 16)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        originalImage?.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        configuracion.image = resizedImage
        button.addTarget(self, action: #selector(searchEarthquake), for: .touchUpInside)
        button.configuration = configuracion
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 98.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 26.0).isActive = true
        return button
    }()
    
    var startTime = ""
    var endTime = ""
    
    init(delegate: DatePickerViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func startDatePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        print("Fecha seleccionada: \(selectedDate)")
        startTime = DateManager.formatDate(selectedDate)
    }
    
    @objc
    private func endDatePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        print("Fecha seleccionada: \(selectedDate)")
        endTime = DateManager.formatDate(selectedDate)
    }
    
    @objc
    private func searchEarthquake() {
        if !startTime.isEmpty && !endTime.isEmpty {
            delegate?.didTapSearch(startTime: startTime, endTime: endTime)
        }
    }
    
}

extension EarthquakeDatePickerView {
    
    private func setupView(){
        
        datePickersContetView.addArrangedSubview(startDatePicker)
        datePickersContetView.addArrangedSubview(endDatePicker)
        datePickersContetView.addArrangedSubview(searchButton)
        
        self.addSubview(datePickersContetView)
        
        NSLayoutConstraint.activate([
            
            .init(item: datePickersContetView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: datePickersContetView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
            .init(item: datePickersContetView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: datePickersContetView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            .init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 26.0)
        ])
    }
}


