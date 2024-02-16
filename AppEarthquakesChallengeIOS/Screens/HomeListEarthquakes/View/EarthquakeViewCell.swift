//
//  EarthquakeViewCell.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation
import UIKit

class EarthquakeViewCell: UITableViewCell {
    
    private lazy var earthquakeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "target")
        imageView.tintColor = .systemRed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT bold", size: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT", size: 10)
        label.textAlignment = .left
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var magnitudeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT", size: 10)
        label.textAlignment = .left
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var depthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial Rounded MT", size: 10)
        label.textAlignment = .left
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()
    
    lazy var detailButton: UIButton = {
        let button = UIButton()
        var configuracion = UIButton.Configuration.borderedTinted()
        configuracion.titleAlignment = .center
        configuracion.baseForegroundColor = .systemGray
        configuracion.baseBackgroundColor = .white
        
        let underlineTitle = AttributedString("Ver Detalles", attributes: AttributeContainer([.underlineStyle: NSUnderlineStyle.single.rawValue]))
        configuracion.attributedTitle = underlineTitle
                        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.configuration = configuracion
        button.translatesAutoresizingMaskIntoConstraints = false
                
        return button
    }()
    private var titleString: String? {
        didSet{
            titleLabel.text = "Terremoto: \(String(describing: titleString))"
        }
    }
        
    private var magnitudeString: String? {
        didSet{
            magnitudeLabel.text = "Magnitud: \(String(describing: magnitudeString))"
        }
    }
    
    private var depthString: String? {
        didSet{
            depthLabel.text = "Profundidad: \(String(describing: depthString))"
        }
    }
        
    private var placeString: String? {
        didSet{
            placeLabel.text = "Lugar: \(String(describing: placeString))"
        }
    }
    
    var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        self.contentView.addSubview(earthquakeImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(magnitudeLabel)
        self.contentView.addSubview(depthLabel)
        self.contentView.addSubview(placeLabel)
        self.contentView.addSubview(detailButton)
        
        NSLayoutConstraint.activate([
            .init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 10.0),
            .init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 8.0),
            .init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -8.0),
            
            .init(item: earthquakeImageView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 8.0),
            .init(item: earthquakeImageView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 8.0),
            .init(item: earthquakeImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0),
            .init(item: earthquakeImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0),
            
            
            
            .init(item: magnitudeLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            .init(item: magnitudeLabel, attribute: .leading, relatedBy: .equal, toItem: earthquakeImageView, attribute: .trailing, multiplier: 1.0, constant: 8.0),
            .init(item: magnitudeLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -8.0),
            
            .init(item: depthLabel, attribute: .top, relatedBy: .equal, toItem: magnitudeLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            .init(item: depthLabel, attribute: .leading, relatedBy: .equal, toItem: earthquakeImageView, attribute: .trailing, multiplier: 1.0, constant: 8.0),
            .init(item: depthLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -8.0),
            
            .init(item: placeLabel, attribute: .top, relatedBy: .equal, toItem: depthLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0),
            .init(item: placeLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 8.0),
            .init(item: placeLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -8.0),
            
            .init(item: detailButton, attribute: .top, relatedBy: .equal, toItem: placeLabel, attribute: .bottom, multiplier: 1.0, constant: 16.0),
            .init(item: detailButton, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 8.0),
            .init(item: detailButton, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -8.0),
            .init(item: detailButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0),
            .init(item: self.contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0)
            
        ])
    }
    
    public func configure(title: String, magnitude: Double, depth: Double, place: String) {
        titleString = title
        magnitudeString = "\(magnitude)"
        depthString = "\(depth)"
        placeString = place
    }
    
    @objc func buttonTapped() {
        buttonAction?()
    }
}
