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
        //delegate?.datePickerValueChanged()
    }
    
    @objc
    private func endDatePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        print("Fecha seleccionada: \(selectedDate)")
        endTime = DateManager.formatDate(selectedDate)
        //delegate?.datePickerValueChanged()
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
            //.init(item: searchButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0),
            //.init(item: searchButton, attribute: .top, relatedBy: .equal, toItem: datePickersContetView, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: searchButton, attribute: .centerY, relatedBy: .equal, toItem: datePickersContetView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            .init(item: searchButton, attribute: .trailing, relatedBy: .equal, toItem: datePickersContetView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        ])
    }
}

/*class EarthquakeDatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT", size: 16)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Busca por fecha"
        
        return label
    }()
    
    private let startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(picker, action: #selector(startDatePickerValueChanged), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(picker, action: #selector(endDatePickerValueChanged), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.baseForegroundColor = .black
        configuracion.baseBackgroundColor = .systemGray2
        
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchEarthquake), for: .touchUpInside)
        button.configuration = configuracion
        //button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    private let datePickersContetView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.spacing = 20.0
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
    private func startDatePickerValueChanged() {
        let selectedDate = startDatePicker.date
        // Aquí puedes aplicar la lógica de filtrado con la fecha seleccionada
        print("Fecha seleccionada: \(selectedDate)")
        startTime = DateManager.formatDate(selectedDate)
        //delegate?.datePickerValueChanged()
    }
    
    @objc
    private func endDatePickerValueChanged() {
        let selectedDate = startDatePicker.date
        // Aquí puedes aplicar la lógica de filtrado con la fecha seleccionada
        print("Fecha seleccionada: \(selectedDate)")
        endTime = DateManager.formatDate(selectedDate)
        //delegate?.datePickerValueChanged()
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
        self.addSubview(titleLabel)
        self.addSubview(datePickersContetView)
        datePickersContetView.addSubview(startDatePicker)
        datePickersContetView.addSubview(endDatePicker)
        datePickersContetView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
            .init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0),
            
            .init(item: datePickersContetView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            .init(item: datePickersContetView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: datePickersContetView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20),
            .init(item: datePickersContetView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50),
            .init(item: datePickersContetView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10.0),
            .init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
        ])
        
        NSLayoutConstraint.activate([
            .init(item: searchButton, attribute: .leading, relatedBy: .equal, toItem: endDatePicker, attribute: .trailing, multiplier: 1.0, constant: 20.0),
            .init(item: searchButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0),
            .init(item: searchButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0),
            .init(item: searchButton, attribute: .centerY, relatedBy: .equal, toItem: datePickersContetView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            .init(item: searchButton, attribute: .trailing, relatedBy: .equal, toItem: datePickersContetView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        ])
    }
}*/
/*
 protocol DatePickerViewDelegate: AnyObject {
     //func datePickerValueChanged()
     func didTapSearch(startTime: String, endTime: String)
 }

 class EarthquakeDatePickerView: UIView {
     
     weak var delegate: DatePickerViewDelegate?
     
     private lazy var titleLabel: UILabel = {
         let label = UILabel(frame: .zero)
         label.font = UIFont(name: "Arial Rounded MT", size: 16)
         label.textAlignment = .left
         label.textColor = .black
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = "Busca por fecha"
         
         return label
     }()
     
     private let startDatePicker: UIDatePicker = {
         let picker = UIDatePicker()
         picker.datePickerMode = .date
         picker.addTarget(picker, action: #selector(startDatePickerValueChanged), for: .valueChanged)
         picker.translatesAutoresizingMaskIntoConstraints = false
         return picker
     }()
     
     private let endDatePicker: UIDatePicker = {
         let picker = UIDatePicker()
         picker.datePickerMode = .date
         picker.addTarget(picker, action: #selector(endDatePickerValueChanged), for: .valueChanged)
         picker.translatesAutoresizingMaskIntoConstraints = false
         return picker
     }()
     
     lazy var searchButton: UIButton = {
         let button = UIButton()
         var configuracion = UIButton.Configuration.borderedTinted()
         configuracion.baseForegroundColor = .black
         configuracion.baseBackgroundColor = .systemGray2
         
         button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
         button.addTarget(self, action: #selector(searchEarthquake), for: .touchUpInside)
         button.configuration = configuracion
         //button.isEnabled = false
         button.translatesAutoresizingMaskIntoConstraints = false
                 
         return button
     }()
     
     private let datePickersContetView: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     private let searchContetView: UIView = {
         let view = UIView()
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
     private func startDatePickerValueChanged() {
         let selectedDate = startDatePicker.date
         // Aquí puedes aplicar la lógica de filtrado con la fecha seleccionada
         print("Fecha seleccionada: \(selectedDate)")
         startTime = DateManager.formatDate(selectedDate)
         //delegate?.datePickerValueChanged()
     }
     
     @objc
     private func endDatePickerValueChanged() {
         let selectedDate = startDatePicker.date
         // Aquí puedes aplicar la lógica de filtrado con la fecha seleccionada
         print("Fecha seleccionada: \(selectedDate)")
         endTime = DateManager.formatDate(selectedDate)
         //delegate?.datePickerValueChanged()
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
         self.addSubview(searchContetView)
         searchContetView.addSubview(titleLabel)
         searchContetView.addSubview(searchButton)
         self.addSubview(datePickersContetView)
         datePickersContetView.addSubview(startDatePicker)
         datePickersContetView.addSubview(endDatePicker)
         
         NSLayoutConstraint.activate([
             
             .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: searchContetView, attribute: .top, multiplier: 1.0, constant: 0.0),
             .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: searchContetView, attribute: .leading, multiplier: 1.0, constant: 0.0),
             .init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: searchContetView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
             
             .init(item: searchButton, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 20.0),
             .init(item: searchButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 24),
             .init(item: searchButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 24),
             .init(item: searchButton, attribute: .centerY, relatedBy: .equal, toItem: searchContetView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
             .init(item: searchButton, attribute: .trailing, relatedBy: .equal, toItem: searchContetView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
         ])
         
         NSLayoutConstraint.activate([
             
             .init(item: startDatePicker, attribute: .top, relatedBy: .equal, toItem: datePickersContetView, attribute: .top, multiplier: 1.0, constant: 0.0),
             .init(item: startDatePicker, attribute: .leading, relatedBy: .equal, toItem: datePickersContetView, attribute: .leading, multiplier: 1.0, constant: 0.0),
             //.init(item: startDatePicker, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120),
             .init(item: startDatePicker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50),
             .init(item: startDatePicker, attribute: .bottom, relatedBy: .equal, toItem: datePickersContetView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
             
             .init(item: endDatePicker, attribute: .top, relatedBy: .equal, toItem: datePickersContetView, attribute: .top, multiplier: 1.0, constant: 0.0),
             .init(item: endDatePicker, attribute: .leading, relatedBy: .equal, toItem: startDatePicker, attribute: .trailing, multiplier: 1.0, constant: 20.0),
             .init(item: endDatePicker, attribute: .trailing, relatedBy: .equal, toItem: datePickersContetView, attribute: .trailing, multiplier: 1.0, constant: 0.0),
             .init(item: endDatePicker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50),
             .init(item: endDatePicker, attribute: .bottom, relatedBy: .equal, toItem: datePickersContetView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
         ])
         
         NSLayoutConstraint.activate([
             
             .init(item: searchContetView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
             .init(item: searchContetView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
             .init(item: searchContetView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
             .init(item: searchContetView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0),
             
             .init(item: datePickersContetView, attribute: .top, relatedBy: .equal, toItem: searchContetView, attribute: .bottom, multiplier: 1.0, constant: 10.0),
             .init(item: datePickersContetView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
             .init(item: datePickersContetView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20),
             .init(item: datePickersContetView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50),
             .init(item: datePickersContetView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10.0),
             .init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
         ])
     }
 }
 */

/*class DatePickerView: UIView {
    
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
        //delegate?.datePickerValueChanged()
    }
    
    @objc
    private func searchEarthquake() {
        //delegate?.didTapSearch()
    }
    
}

extension DatePickerView {
    private func setupView(){
        
        self.addSubview(titleLabel)
        self.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
            
            .init(item: datePicker, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: datePicker, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
            .init(item: datePicker, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
        ])
    }
}*/
/*
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
     
     private let startDatePicker: UIDatePicker = {
         let picker = UIDatePicker()
         picker.datePickerMode = .date
         picker.addTarget(picker, action: #selector(datePickerValueChanged), for: .valueChanged)
         picker.translatesAutoresizingMaskIntoConstraints = false
         return picker
     }()
     
     private let endDatePicker: UIDatePicker = {
         let picker = UIDatePicker()
         picker.datePickerMode = .date
         picker.addTarget(picker, action: #selector(datePickerValueChanged), for: .valueChanged)
         picker.translatesAutoresizingMaskIntoConstraints = false
         return picker
     }()
     
     lazy var searchButton: UIButton = {
         let button = UIButton()
         var configuracion = UIButton.Configuration.borderedTinted()
         configuracion.baseForegroundColor = .black
         configuracion.baseBackgroundColor = .systemGray2
         
         button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
         button.addTarget(self, action: #selector(searchEarthquake), for: .touchUpInside)
         button.configuration = configuracion
         button.translatesAutoresizingMaskIntoConstraints = false
                 
         return button
     }()
     
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
         self.addSubview(startDatePicker)
         self.addSubview(endDatePicker)
         self.addSubview(searchButton)
         
         NSLayoutConstraint.activate([
             
             .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
             .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
             .init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
             
             .init(item: startDatePicker, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
             .init(item: startDatePicker, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0.0),
             .init(item: startDatePicker, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
             .init(item: startDatePicker, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
             
             .init(item: endDatePicker, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
             .init(item: endDatePicker, attribute: .leading, relatedBy: .equal, toItem: startDatePicker, attribute: .trailing, multiplier: 1.0, constant: 0.0),
             .init(item: endDatePicker, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
             .init(item: endDatePicker, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
             
             .init(item: searchButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
             .init(item: searchButton, attribute: .leading, relatedBy: .equal, toItem: endDatePicker, attribute: .trailing, multiplier: 1.0, constant: 10.0),
             .init(item: searchButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
             .init(item: searchButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0),
             .init(item: searchButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0),
         ])
     }
 }
 */

/*
 view.addSubview(datePicker)

         // Configura las restricciones de diseño (puedes usar Auto Layout o frames)
         datePicker.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
 */
