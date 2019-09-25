//
//  ViewController.swift
//  Drawing
//
//  Created by Sirarpi on 9/24/19.
//  Copyright © 2019 Sirarpi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
    }
  
    @IBAction func colorButton(_ sender: UIButton) {
        CanvasView.setStrokeColor(color:sender.backgroundColor!)
}
    //    func setupLayout(){
//        let stackView = UIStackView(arrangedSubviews: [
//           // undoButton,
//           // clearButton
//            ])
//        stackView.distribution = .fillEqually
//        view.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(canvas)
        
        canvas.backgroundColor = .white
       // setupLayout()
        //canvas.frame = view.frame
    }
}




