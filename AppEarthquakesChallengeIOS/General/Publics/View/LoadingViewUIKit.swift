//
//  LoadingViewUIKit.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 14-03-24.
//

import Foundation
import UIKit

class LoadingViewUIKit: UIView {
    var isLoading: Bool = false {
        didSet {
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0
            animation.toValue = 2 * Double.pi
            animation.duration = 1
            animation.repeatCount = Float.infinity

            let shapeLayer = CAShapeLayer()
            let path = UIBezierPath(arcCenter: center, radius: 50, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.lineWidth = 5
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeEnd = 0.7
            layer.addSublayer(shapeLayer)

            if isLoading {
                shapeLayer.add(animation, forKey: "rotation")
            } else {
                shapeLayer.removeAnimation(forKey: "rotation")
            }
        }
    }
}
