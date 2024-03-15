//
//  ErrorViewUIKit.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 14-03-24.
//

import UIKit

class ErrorViewUIKit: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: viewModel.namedImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT bold", size: 28)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT", size: 10)
        label.textAlignment = .left
        label.textColor = .systemGray
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.title = "Reintentar"
        configuracion.titleAlignment = .center
        configuracion.baseForegroundColor = .systemGray
        configuracion.baseBackgroundColor = .white
        configuracion.cornerStyle = .medium
        configuracion.buttonSize = .large
                        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.configuration = configuracion
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    
    let viewModel: ErrorViewModel
    
    init(viewModel: ErrorViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonTapped() {
        viewModel.action()
    }
}
