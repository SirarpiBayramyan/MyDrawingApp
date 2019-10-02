//
//  DrawViewController.swift
//  Drawing
//
//  Created by Sirarpi on 9/29/19.
//  Copyright © 2019 Sirarpi. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    var layerIndex = Int()
    var layer: TypeShapeLayer?
    var panGesture = UIPanGestureRecognizer()
    var shapeLayerColor: UIColor = .black
    var oldpozitions = [CGPoint]()
    
    
    @IBOutlet weak var canvasViewOutlet: Canvas!
    
    @IBAction func cleanButton(_ sender: UIButton) {
        canvasViewOutlet.clear()

    }
    @IBAction func redoButton(_ sender: UIButton) {
        canvasViewOutlet.redo()
    }
    @IBAction func undoButton(_ sender: UIButton) {
        if canvasViewOutlet.mode == .draw {
        canvasViewOutlet.undo()
        }

    }
    
    @IBAction func slider(_ sender: UISlider) {
        sender.minimumValue = 3
        sender.maximumValue = 10
        canvasViewOutlet.setStrokeWidth(width: CGFloat(sender.value))
       // print(sender.value)
    }
    
    @IBAction func pancil(_ sender: UIButton) {
        canvasViewOutlet.setStrokeColor(color:.black)
        canvasViewOutlet.setStrokeWidth(width: 1)
    }
    
    @IBAction func rubberButton(_ sender: UIButton) {
        canvasViewOutlet.setStrokeColor(color:canvasViewOutlet.backgroundColor!)
        canvasViewOutlet.setStrokeWidth(width: 10)
    }
  
    @IBAction func colorButton(_ sender: UIButton) {
        canvasViewOutlet.setStrokeColor(color:sender.backgroundColor!)
}

        
    override func viewDidLoad() {
       super.viewDidLoad()
  
    }

    
    
   
    @IBAction func changeMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            canvasViewOutlet.mode = .draw
            canvasViewOutlet.removeGestureRecognizer(panGesture)
        default:
            canvasViewOutlet.mode = .move
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(recognizer:)))
            canvasViewOutlet.addGestureRecognizer(panGesture)
        }
    }
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
            
            switch recognizer.state {
            case .began:
                 canvasViewOutlet.path = UIBezierPath()
                print( canvasViewOutlet.shapeLayers.count)
                for (i, shapeLayer) in  canvasViewOutlet.shapeLayers.enumerated() {
                    let loc =   canvasViewOutlet.layer.convert(recognizer.location(in:  canvasViewOutlet), to: shapeLayer.drawLayer)
    //                CGPoint pointInLayer = [[layer presentationLayer] convertPoint:movingPoint fromLayer:self.view.layer];
    //                CGRect layerBounds = [[layer presentationLayer] bounds];
    //                let loc: CGPoint = shapeLayer.drawLayer.convert(recognizer.location(in: drawingViewOutlet), to: drawingViewOutlet.layer)
    //                if (CGRectContainsPoint(layerBounds, pointInLayer)) {
    //                    // Intersect!
    //                }
                    if (shapeLayer.drawLayer.path?.contains(loc))! {
                        print("begin")
                        layer = TypeShapeLayer(shapeLayer: shapeLayer.drawLayer, color: shapeLayerColor)
                        layerIndex = i
                       canvasViewOutlet.shapeLayers[layerIndex] = layer!
                        //
    //                    drawingViewOutlet.shapeLayers[i].movePosition = shapeLayer.drawLayer.position
    //                    drawingViewOutlet.undoLayers.append(drawingViewOutlet.shapeLayers[i])
                    }
                }
            case .changed:
                print("changed")
              // drawingViewOutlet.path = UIBezierPath()
                guard let layer = layer else { return }
                let translation = recognizer.translation(in: recognizer.view)
                
                CATransaction.begin();
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
    //            redLayer.convert(position, to: yellowLayer
               
                //var layerCoordinate = layer.convert(layer.drawLayer.lo, to: drawingViewOutlet.layer)
                layer.drawLayer.position = CGPoint(x: layer.drawLayer.position.x + translation.x, y: layer.drawLayer.position.y + translation.y)
                
                canvasViewOutlet.draw(canvasViewOutlet.bounds)
                recognizer.setTranslation(CGPoint.zero, in: canvasViewOutlet)

                CATransaction.commit();
                
                
            case .ended:
                print("gredu")
                
                guard let _ = layer else { return }
                
                canvasViewOutlet.shapeLayers.insert(layer!, at: layerIndex)
                print(canvasViewOutlet.shapeLayers.count)
            default:
                break
        }
        
    }
    
}

