//
//  EarthquakeDatePickerView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 25-01-24.
//

import Foundation
import UIKit

protocol DatePickerViewDelegate: AnyObject {
    //func datePickerValueChanged()
    func didTapSearch(startTime: String, endTime: String)
}

class EarthquakeDatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    
    private let startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(picker, action: #selector(startDatePickerValueChanged), for: .valueChanged)
        picker.date = DateManager.getPreviousDate()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(picker, action: #selector(endDatePickerValueChanged), for: .valueChanged)
        picker.date = DateManager.getCurrentDate()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.baseForegroundColor = .black
        configuracion.baseBackgroundColor = .systemGray2
        configuracion.title = "Buscar"
        configuracion.image = UIImage(systemName: "magnifyingglass")
        //button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchEarthquake), for: .touchUpInside)
        button.configuration = configuracion
        //button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    private let datePickersContetView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.spacing = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.addSubview(datePickersContetView)
        datePickersContetView.addSubview(startDatePicker)
        datePickersContetView.addSubview(endDatePicker)
        datePickersContetView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            .init(item: datePickersContetView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: datePickersContetView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: datePickersContetView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20),
            .init(item: datePickersContetView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50),
            .init(item: datePickersContetView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10.0),
            .init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: searchButton, attribute: .leading, relatedBy: .equal, toItem: endDatePicker, attribute: .trailing, multiplier: 1.0, constant: 10.0),
            .init(item: searchButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0),
            .init(item: searchButton, attribute: .centerY, relatedBy: .equal, toItem: datePickersContetView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            .init(item: searchButton, attribute: .trailing, relatedBy: .equal, toItem: datePickersContetView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        ])
    }
}


