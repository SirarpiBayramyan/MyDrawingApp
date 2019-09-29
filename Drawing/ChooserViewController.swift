//
//  ChooserViewController.swift
//  Drawing
//
//  Created by Sirarpi on 9/29/19.
//  Copyright © 2019 Sirarpi. All rights reserved.
//

import UIKit
import Darwin
class ChooserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func exit(_ sender: UIButton) {
        Darwin.exit(EXIT_SUCCESS)
    }
    
}

//    // MARK: - Navigation
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//}

