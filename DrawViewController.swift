//
//  DrawViewController.swift
//  Drawing
//
//  Created by Sirarpi on 9/29/19.
//  Copyright © 2019 Sirarpi. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    var snapX:CGFloat = 40.0
    
    /// must be >= 1.0
    var snapY:CGFloat = 1.0
    
    /// how far to move before dragging
    var threshold:CGFloat = 0.0
    
    /// the guy we're dragging
    var selectedView:UIView?
    
    /// drag in the Y direction?
    var shouldDragY = true
    
    /// drag in the X direction?
    var shouldDragX = true
    
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
    
    @IBAction func slider(_ sender: UISlider) {
        sender.minimumValue = 3
        sender.maximumValue = 10
        CanvasView.setStrokeWidth(width: CGFloat(sender.value))
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

        
    override func viewDidLoad() {
       super.viewDidLoad()
  
    }

    

    @IBAction func drawDrag(_ sender: UISegmentedControl) {
        CanvasView.mode = sender.selectedSegmentIndex == 0 ? .draw : .move
//        if (CanvasView.mode == .drag) {
//            setupGestures()
//        }
    }
}
extension UIView {
    func removeLayer() {
            for item in self.layer.sublayers ?? []  {
                    item.removeFromSuperlayer()
            }
        }
}
