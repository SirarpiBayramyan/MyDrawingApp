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
    var points: [CGPoint]
}


class Canvas: UIView {
    var count = 0
    var lines = [Line]()
    var redoLines = [Line]()
    var strokeColor = UIColor.black
    var strokeWidth: Float = 2
    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }
    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
        setNeedsDisplay()
    }
    
    func undo() {
        
        guard !lines.isEmpty  else { return }
        redoLines.append(lines.removeLast())
        
        setNeedsDisplay()
        
    }
    func redo () {
        guard !redoLines.isEmpty  else { return }
        lines.append(redoLines.removeLast())
        setNeedsDisplay()
    }
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidt))
            context.setLineCap(.round)
            for (index, point) in line.points.enumerated() {
                if index == 0 {
                    context.move(to: point)
                }
                else {
                    print(point)
                    context.addLine(to: point)
                }
            }
            context.strokePath()
            
        }
        print(count)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: strokeColor, strokeWidt:strokeWidth , points:
            []))
        count += 1
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        count += 1
        setNeedsDisplay()
    
    }
    
}
