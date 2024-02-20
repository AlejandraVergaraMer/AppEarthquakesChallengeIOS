//
//  EarthquakePagerView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 25-01-24.
//

import Foundation
import UIKit

protocol EarthquakePagerViewDelegate: AnyObject {
    func didTapNextPage()
    func didTapPreciousPage()
}

class EarthquakePagerView: UIView {
    
    weak var delegate: EarthquakePagerViewDelegate?
    
    lazy var nextPageButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.title = ">"
        configuracion.titleAlignment = .center
        configuracion.baseForegroundColor = .black
        configuracion.baseBackgroundColor = .white.withAlphaComponent(0.8)
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
        configuracion.baseBackgroundColor = .white.withAlphaComponent(0.8)
                        
        button.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        button.configuration = configuracion
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    init(delegate: EarthquakePagerViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func nextPage() {
        delegate?.didTapNextPage()
    }
    
    @objc
    private func previousPage() {
        delegate?.didTapPreciousPage()
    }
}

extension EarthquakePagerView {
    private func setupView(){
        
        self.addSubview(nextPageButton)
        self.addSubview(previousPageButton)
        
        NSLayoutConstraint.activate([
            
            .init(item: previousPageButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: previousPageButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
            .init(item: previousPageButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            .init(item: previousPageButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0),
            .init(item: previousPageButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0),
            
            .init(item: nextPageButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            .init(item: nextPageButton, attribute: .leading, relatedBy: .equal, toItem: previousPageButton, attribute: .trailing, multiplier: 1.0, constant: 6.0),
            .init(item: nextPageButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            .init(item: nextPageButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            .init(item: nextPageButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0),
            .init(item: nextPageButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0),
        ])
    }
}

