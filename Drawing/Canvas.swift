//
//  Canvas.swift
//  Drawing
//
//  Created by Sirarpi on 9/24/19.
//  Copyright © 2019 Sirarpi. All rights reserved.
//

import UIKit

struct Line {
    let color: UIColor
    var strokeWidt: Float
    var path: UIBezierPath
}


class Canvas: UIView {
   
    var pathLine = [Line]()
    var redoLines = [Line]()
    var strokeColor = UIColor.black
    var strokeWidth: Float = 2
    var path = UIBezierPath()
    
    func setupPath() {
        path = UIBezierPath()
        path.lineWidth = CGFloat(strokeWidth)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round

    }
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
        setNeedsDisplay()
    }
    
    func undo() {
        
        guard !pathLine.isEmpty  else { return }
        redoLines.append(pathLine.removeLast())
        setNeedsDisplay()
        
    }
    func redo () {
        guard !redoLines.isEmpty  else { return }
        pathLine.append(redoLines.removeLast())
        setNeedsDisplay()
    }
    func clear() {
        pathLine.removeAll()
        setNeedsDisplay()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setupPath()
        let touch = touches.first!
        setupPath()
        path.move(to: touch.location(in: self))
        pathLine.append(Line(color: strokeColor, strokeWidt: strokeWidth, path: path))
        setNeedsDisplay()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        path.addLine(to: touch.location(in: self))
        setNeedsDisplay()
    
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        path.addLine(to: touch.location(in: self))
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        path.addLine(to: touch.location(in: self))
        setNeedsDisplay()
    }
   
}
