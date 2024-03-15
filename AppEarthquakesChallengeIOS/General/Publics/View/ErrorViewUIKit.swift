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
        //configuracion.t = UIFont.boldSystemFont(ofSize: 20)
                        
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
/*
 init(image: UIImage, title: String, description: String, action: @escaping () -> Void) {
     super.init(frame: .zero)

     imageView.image = image
     titleLabel.text = title
     descriptionLabel.text = description
     button.setTitle("Intentar de nuevo", for: .normal)
     button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

     // Aquí agregarías el código para configurar y agregar las vistas a tu jerarquía de vistas y establecer las restricciones de Auto Layout.
 }
 */
