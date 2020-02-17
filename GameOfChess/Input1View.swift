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
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(firstColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        
        
        
    }
    
    
    @IBAction func confirmButtonClick(_ sender: Any) {
        performSegue(withIdentifier: segueToInput2View, sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
}
