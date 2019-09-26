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
    var index: Int = 0
    
    init(_ color: UIColor, _ strokeWidth:Float  ,_ path: UIBezierPath ){
        self.color = color
        self.strokeWidt = strokeWidth
        self.path = path
    }
}


class Canvas: UIView, UIGestureRecognizerDelegate {
   
    var pathLine = [Line]()
    var redoLines = [Line]()
    var strokeColor = UIColor.black
    var strokeWidth: Float = 2
    var path = UIBezierPath()
    var shapeLayer: CAShapeLayer!
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
   //Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setupPath()
        let touch = touches.first!
        setupPath()
        path.move(to: touch.location(in: self))
        pathLine.append(Line(strokeColor, strokeWidth, path))
               
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
    

    override func draw(_ rect: CGRect)
    {
        for path_ in pathLine{
            path_.color.setStroke()
            path_.path.stroke()
            
        }
    }
}
  
//extension UIView {
//
//    // Using a function since `var image` might conflict with an existing variable
//    // (like on `UIImageView`)
//    func asImage() -> UIImage {
//        if #available(iOS 10.0, *) {
//            let renderer = UIGraphicsImageRenderer(bounds: bounds)
//            return renderer.image { rendererContext in
//                layer.render(in: rendererContext.cgContext)
//            }
//        } else {
//            UIGraphicsBeginImageContext(self.frame.size)
//            self.layer.render(in:UIGraphicsGetCurrentContext()!)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return UIImage(cgImage: image!.cgImage!)
//        }
//    }
//}

   


