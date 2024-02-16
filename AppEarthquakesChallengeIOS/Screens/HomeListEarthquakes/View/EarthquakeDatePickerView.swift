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

class EarthquakeDatePickerView: UIView {
    
    weak var delegate: DatePickerViewDelegate?
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(picker, action: #selector(datePickerValueChanged), for: .valueChanged)
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
        
        self.addSubview(datePicker)
        self.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            .init(item: datePicker, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: datePicker, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: datePicker, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -20.0),
            
            .init(item: searchButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 50.0),
            .init(item: searchButton, attribute: .leading, relatedBy: .equal, toItem: datePicker, attribute: .leading, multiplier: 1.0, constant: 20.0),
            .init(item: searchButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0),
            .init(item: searchButton, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0),
            .init(item: searchButton, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0),
        ])
    }
}

/*
 private func setupView(){
     
     self.addSubview(scrollView)
     self.scrollView.addSubview(contentView)
     
     scrollView.addSubview(titleLabel)
     scrollView.addSubview(emailTextField)
     scrollView.addSubview(passwordTextField)
     scrollView.addSubview(loginButton)
     scrollView.addSubview(userRegisterButton)
     
     NSLayoutConstraint.activate([
         .init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
     ])

     NSLayoutConstraint.activate([
         .init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1.0, constant: 0.0),
         .init(item: scrollView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .height, multiplier: 1.0, constant: 0.0)
     ])
     
     NSLayoutConstraint.activate([
         
         .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10.0),
         .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 20.0),
         .init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -20.0),
         
         .init(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 50.0),
         .init(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 20.0),
         .init(item: emailTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -20.0),
         
         .init(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1.0, constant: 40.0),
         .init(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 20.0),
         .init(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -20.0),
         
         .init(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1.0, constant: 150.0),
         .init(item: loginButton, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 40.0),
         .init(item: loginButton, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -40.0),
         
         .init(item: userRegisterButton, attribute: .top, relatedBy: .equal, toItem: loginButton, attribute: .bottom, multiplier: 1.0, constant: 50.0),
         .init(item: userRegisterButton, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 40.0),
         .init(item: userRegisterButton, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -40.0)
     ])
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
