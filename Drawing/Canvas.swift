//
//  Canvas.swift
//  Drawing
//
//  Created by Sirarpi on 9/24/19.
//  Copyright © 2019 Sirarpi. All rights reserved.
//

import UIKit

struct TypeShapeLayer {
    var drawLayer: CAShapeLayer
    var color: UIColor
    
    init(shapeLayer: CAShapeLayer, color: UIColor) {
        self.drawLayer = shapeLayer
        self.color = color
    }
}


class Canvas: UIView, UIGestureRecognizerDelegate {
    enum Mode {
        case draw
        case move

    }
    var mode:Mode = .draw
    
    
    var isDrawable: Bool = true
    var shapeLayers = [TypeShapeLayer]()
    var undoRedoLayers = [TypeShapeLayer]()
    var strokeColor = UIColor.black
    var strokeWidth: CGFloat = 2
    var path = UIBezierPath()
    var shapeLayer = CAShapeLayer()
    func setupPath() {
        path = UIBezierPath()
        path.lineWidth = CGFloat(strokeWidth)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round

    }
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    func setStrokeWidth(width: CGFloat) {
        self.strokeWidth = width
        setNeedsDisplay()
    }
    
    func undo() {
        
        guard !shapeLayers.isEmpty  else { return }
        undoRedoLayers.append(shapeLayers.removeLast())
        setNeedsDisplay()
        
    }
    func redo () {
        guard !undoRedoLayers.isEmpty  else { return }
        shapeLayers.append(undoRedoLayers.removeLast())
        
        setNeedsDisplay()
    }
    func clear() {
        guard !shapeLayers.isEmpty else { return }
        for _ in shapeLayers {
            layer.sublayers?.removeLast()
        }
        path = UIBezierPath()
        setNeedsDisplay()      
    }
    
   //Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if mode == .draw {
            path = UIBezierPath()
            path.lineWidth = strokeWidth
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            let touch = touches.first!
            path.move(to: touch.location(in: self))
            undoRedoLayers = []
        }
        setNeedsDisplay()
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if mode == .draw {
            let touch = touches.first!
            path.addLine(to: touch.location(in: self))
            
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if mode == .draw {
            let touch = touches.first!
            path.addLine(to: touch.location(in: self))
            touchEnded()
        }
        setNeedsDisplay()
    }
   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if mode == .draw {
            let touch = touches.first!
            path.addLine(to: touch.location(in: self))
            touchEnded()
        }
        setNeedsDisplay()
    }
    
    func touchEnded() {
           
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = path.lineWidth
        shapeLayer.opacity = 1
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = nil
        shapeLayers.append(TypeShapeLayer(shapeLayer: shapeLayer, color: strokeColor))
        layer.addSublayer(shapeLayer)
        let newActions = [
            "onOrderIn": NSNull(),
            "onOrderOut": NSNull(),
            "sublayers": NSNull(),
            "contents": NSNull(),
            "bounds": NSNull(),
        ]
        shapeLayer.actions = newActions
        setNeedsDisplay()
    }
   
    
    override func draw(_ rect: CGRect)
    {
        if mode == .draw {
            
            strokeColor.setStroke()
            path.stroke()
        }
    }
}


   

