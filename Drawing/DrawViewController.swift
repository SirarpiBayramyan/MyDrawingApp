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

        
    override func viewDidLoad() {
//        super.viewDidLoad()
//        CanvasView.isUserInteractionEnabled = true
//        CanvasView.addGestureRecognizer(dragPan)
        
           
    }
    let dragPan = UIPanGestureRecognizer(target: self, action: #selector(drag(recognizer:)))
         //  view.addGestureRecognizer(dragPan)
    @objc func drag(recognizer: UIPanGestureRecognizer)
    {
        
        
        
    }
}
    

