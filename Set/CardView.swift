//
//  CardView.swift
//  Set
//
//  Created by Yves Kurz on 17.08.18.
//  Copyright © 2018 Yves Kurz. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    
    struct FigurePositions {
        static let figureStartXFactor = CGFloat(1.0)
        static let figure1of3StartYFactor = CGFloat(1.5)
        static let figure2of3StartYFactor = CGFloat(3.5)
        static let figure3of3StartYFactor = CGFloat(5.5)
        static let figure1of2StartYFactor = CGFloat(2.625)
        static let figure2of2StartYFactor = CGFloat(4.375)
    }
    
    struct DiamondFigurePositions {
        static let topYOffset = CGFloat(0)
        static let topXOffset = CGFloat(1.5)
        static let leftYOffset = CGFloat(0.5)
        static let leftXOffset = CGFloat(0)
        static let bottomYOffset = CGFloat(1.0)
        static let bottomXOffset = CGFloat(1.5)
        static let rightYOffset = CGFloat(0.5)
        static let rightXOffset = CGFloat(3)
    }
    
    struct OvalFigurePositions {
        static let topLeftYOffset = CGFloat(0)
        static let topLeftXOffset = CGFloat(0.5)
        static let topRightYOffset = CGFloat(0)
        static let topRightXOffset = CGFloat(2.5)
        static let bottomLeftYOffset = CGFloat(1)
        static let bottomLeftXOffset = CGFloat(0.5)
        static let bottomRightYOffset = CGFloat(1)
        static let bottomRightXOffset = CGFloat(2.5)
        static let centerLeftYOffset = CGFloat(0.5)
        static let centerLeftXOffset = CGFloat(0.5)
        static let centerRightYOffset = CGFloat(0.5)
        static let centerRightXOffset = CGFloat(2.5)
    }
    
    @objc enum Face: Int {
        case squiggle
        case oval
        case diamond
    }
    
    @objc enum Fill: Int {
        case solid
        case striped
        case empty
    }
    
    @IBInspectable
    var color: UIColor = UIColor.red
    
    @IBInspectable
    var rank: Int = 1
    
    @IBInspectable
    var fill: Fill = .striped
    
    @IBInspectable
    var face: Face = .squiggle
    
    func createSquigglePath(at offset: CGPoint, scaleXBy: CGFloat, scaleYBy: CGFloat) -> UIBezierPath {
        print (offset, scaleXBy, scaleYBy)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 97, y: 5))
        
        path.addCurve(to: CGPoint(x: 56, y: 42), controlPoint1: CGPoint(x: 105.4, y: 25.9), controlPoint2: CGPoint(x: 82.7, y: 48.8))
        path.addCurve(to: CGPoint(x: 20, y: 41), controlPoint1: CGPoint(x: 45.3, y: 39.3), controlPoint2: CGPoint(x: 35.2, y: 28))
        path.addCurve(to: CGPoint(x: -2, y: 28), controlPoint1: CGPoint(x: 2.6, y: 53.6), controlPoint2: CGPoint(x: -2.4, y: 46.3))
        path.addCurve(to: CGPoint(x: 29, y: 0), controlPoint1: CGPoint(x: -3.6, y: 10), controlPoint2: CGPoint(x: 12.1, y: 3.1))
        path.addCurve(to: CGPoint(x: 82, y: 2), controlPoint1: CGPoint(x: 52.2, y: 3.2), controlPoint2: CGPoint(x: 54.9, y: 19.5))
        path.addCurve(to: CGPoint(x: 98, y: 8), controlPoint1: CGPoint(x: 88.3, y: -2), controlPoint2: CGPoint(x: 97.9, y: -6.9))
        path.apply(CGAffineTransform(scaleX: 1.2 * scaleXBy/40, y: 0.9 * scaleYBy/40))
        path.apply(CGAffineTransform(translationX: offset.x, y: offset.y))

        return path
    }

    func createOvalPath(at offset: CGPoint, scaleXBy: CGFloat, scaleYBy: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: OvalFigurePositions.topRightXOffset, y: OvalFigurePositions.topRightYOffset))
        path.addArc(withCenter: CGPoint(x: OvalFigurePositions.centerRightXOffset, y: OvalFigurePositions.centerRightYOffset), radius: 0.5, startAngle: 1.5 * CGFloat.pi, endAngle: 0.5 * CGFloat.pi, clockwise: true)
        path.addLine(to: CGPoint(x: OvalFigurePositions.bottomLeftXOffset, y: OvalFigurePositions.bottomLeftYOffset))
        path.addArc(withCenter: CGPoint(x: OvalFigurePositions.centerLeftXOffset, y: OvalFigurePositions.centerLeftYOffset), radius: 0.5, startAngle: 0.5 * CGFloat.pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        path.close()

        path.apply(CGAffineTransform(scaleX: scaleXBy, y: scaleYBy))
        path.apply(CGAffineTransform(translationX: offset.x, y: offset.y))
        
        path.lineWidth = 2
        
        return path
    }
    
    func createDiamondPath(at offset: CGPoint, scaleXBy: CGFloat, scaleYBy: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: DiamondFigurePositions.topXOffset, y: DiamondFigurePositions.topYOffset))
        path.addLine(to: CGPoint(x: DiamondFigurePositions.leftXOffset, y: DiamondFigurePositions.leftYOffset))
        path.addLine(to: CGPoint(x: DiamondFigurePositions.bottomXOffset, y: DiamondFigurePositions.bottomYOffset))
        path.addLine(to: CGPoint(x: DiamondFigurePositions.rightXOffset, y: DiamondFigurePositions.rightYOffset))
        path.close()

        path.apply(CGAffineTransform(scaleX: scaleXBy, y: scaleYBy))
        path.apply(CGAffineTransform(translationX: offset.x, y: offset.y))

        return path
    }
    
    
    override func draw(_ rect: CGRect) {
        let cgContext = UIGraphicsGetCurrentContext()!
        
        var path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width * 0.1)
        UIColor.yellow.setFill()
        UIColor.lightGray.setStroke()
        path.fill()
        path.stroke()
        

        let xScaleFactor = bounds.width / 5.0
        let yScaleFactor = bounds.height / 8.0
        let xStart = xScaleFactor * FigurePositions.figureStartXFactor
        var yStart = yScaleFactor * FigurePositions.figure1of3StartYFactor
        
        let pathFunction: (CGPoint, CGFloat, CGFloat) -> UIBezierPath
        switch face {
        case .diamond:
            pathFunction = createDiamondPath
        case .oval:
            pathFunction = createOvalPath
        case .squiggle:
            pathFunction = createSquigglePath
        }
        
        func drawFigure () {
            path = pathFunction(CGPoint(x: xStart, y: yStart), xScaleFactor, yScaleFactor)
            path.lineWidth = 0.1 * xScaleFactor
            
            color.setStroke()
            path.stroke()
            
            switch fill {
            case .solid:
                color.setFill()
                path.fill()
            case .striped:
                cgContext.saveGState()
                path.addClip()
                let yEnd = 1 * yScaleFactor
                for lineX in stride(from: 0, to: 3.0 * xScaleFactor, by: path.lineWidth * 2) {
                    print(lineX)
                    path.move(to: CGPoint(x:lineX + xStart, y: yStart - (0.0 * yScaleFactor)))
                    path.addLine(to: CGPoint(x: lineX + xStart, y: yStart + yEnd))
                }
                path.stroke()
                cgContext.restoreGState()
            default:
                break
            }
        }
        
        switch rank {
        case 1:
            yStart = yScaleFactor * FigurePositions.figure2of3StartYFactor
            drawFigure()
        case 2:
            yStart = yScaleFactor * FigurePositions.figure1of2StartYFactor
            drawFigure()
            yStart = yScaleFactor * FigurePositions.figure2of2StartYFactor
            drawFigure()
        case 3:
            yStart = yScaleFactor * FigurePositions.figure1of3StartYFactor
            drawFigure()
            yStart = yScaleFactor * FigurePositions.figure2of3StartYFactor
            drawFigure()
            yStart = yScaleFactor * FigurePositions.figure3of3StartYFactor
            drawFigure()
        default:
            print("Invalid rank: \(rank), rank must be 1-3")
            break;
        }
    }
}
