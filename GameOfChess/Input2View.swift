//
//  Input2View.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class Input2View: UIViewController {
    
    let segueToGameView = "segueToGameView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func confirmButtonClick(_ sender: Any) {
        performSegue(withIdentifier: segueToGameView, sender: self)
    }
}
