//
//  ViewController.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let segueToInput1View = "segueToInput1View"
    let segueToHighscoreView = "segueToHighscoreView"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func playButtonClick(_ sender: Any) {
        performSegue(withIdentifier: segueToInput1View, sender: self)
    }
    
}

