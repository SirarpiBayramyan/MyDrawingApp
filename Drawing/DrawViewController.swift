//
//  ViewController.swift
//  Drawing
//
//  Created by Sirarpi on 9/24/19.
//  Copyright © 2019 Sirarpi. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    let canvas = Canvas()
    
    @IBOutlet weak var CanvasView: Canvas!
    
    @IBAction func cleanButton(_ sender: UIButton) {
        CanvasView.clear()

    }
    @IBAction func redoButton(_ sender: UIButton) {
        CanvasView.redo()
    }
    @IBAction func undoButton(_ sender: UIButton) {
        CanvasView.undo()

    }
    

    
    @IBAction func panDraw(_ sender: UIPanGestureRecognizer) {
    }
    
    @IBAction func slider(_ sender: UISlider) {
        sender.minimumValue = 3
        sender.maximumValue = 10
        CanvasView.setStrokeWidth(width: sender.value)
       // print(sender.value)
    }
    
    @IBAction func pancil(_ sender: UIButton) {
        CanvasView.setStrokeColor(color:.black)
        CanvasView.setStrokeWidth(width: 1)
    }
    
    @IBAction func rubberButton(_ sender: UIButton) {
        CanvasView.setStrokeColor(color:CanvasView.backgroundColor!)
        CanvasView.setStrokeWidth(width: 10)
    }
  
    @IBAction func colorButton(_ sender: UIButton) {
        CanvasView.setStrokeColor(color:sender.backgroundColor!)
}

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }

        

//    @IBAction func pan(_ sender: UIButton) {
//
//        CanvasView.setupGestureRecognizers()
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addGestureRecognizer(pinchMethod)
        
           
    }
}
//    let pinchMethod = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandler(gesture:)))
//    @objc private func pinchHandler(gesture: UIPinchGestureRecognizer) {
//        if let view = gesture.view {
//
//            switch gesture.state {
//            case .changed:
//                let pinchCenter = CGPoint(x: gesture.location(in: view).x - view.bounds.midX,
//                                          y: gesture.location(in: view).y - view.bounds.midY)
//                let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
//                                                .scaledBy(x: gesture.scale, y: gesture.scale)
//                                                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
//                view.transform = transform
//                gesture.scale = 1
//            case .ended:
//                // Nice animation to scale down when releasing the pinch.
//                // OPTIONAL
//                UIView.animate(withDuration: 0.2, animations: {
//                    view.transform = CGAffineTransform.identity
//                })
//            default:
//                return
//            }
//
//
//        }
//    }
//}

