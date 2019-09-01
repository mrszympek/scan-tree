//
//  GradientView.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit

typealias GradientType = (startPoint: CGPoint, endPoint: CGPoint)

/// Enum that holds all available gradient directions
enum GradientDirection {
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    case topRightBottomLeft
    case bottomLeftTopRight
    
    func point() -> GradientType {
        switch self {
        case .leftRight:
            return (startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (startPoint: CGPoint(x: 1, y: 0.5), endPoint: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (startPoint: CGPoint(x: 0.5, y: 1), endPoint: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0, y: 0))
        case .topRightBottomLeft:
            return (startPoint: CGPoint(x: 1, y: 0), endPoint: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0))
        }
    }
}

class GradientView: UIView {
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, colors: [UIColor]) {
        super.init(frame: frame)
        setupView(withColors: colors)
    }
    
    // MARK: - Private
    
    private func setupView(withColors colors: [UIColor]) {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let gradientLayer = layer as? CAGradientLayer else {
            log.error("Cannot cast layer to be CAGradientLayer")
            return
        }
        
        // Transform the received colors into array of cgcolors
        let cgColors = colors.map { (color) -> CGColor in
            return color.cgColor
        }
        gradientLayer.colors = cgColors
        
        // Set the gradient direction
        let point = GradientDirection.topBottom.point()
        gradientLayer.startPoint = point.startPoint
        gradientLayer.endPoint = point.endPoint
        gradientLayer.frame = bounds
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
}

