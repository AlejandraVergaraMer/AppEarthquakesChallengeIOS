//
//  EarthquakePagerView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 25-01-24.
//

import Foundation
import UIKit

class EarthquakePagerView: UIView {
    
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
}

