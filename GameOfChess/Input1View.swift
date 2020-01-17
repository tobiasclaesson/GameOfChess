//
//  Input1View.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class Input1View: UIViewController {
    
    let segueToInput2View = "segueToInput2View"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func confirmButtonClick(_ sender: Any) {
        performSegue(withIdentifier: segueToInput2View, sender: self)
    }
    
}
