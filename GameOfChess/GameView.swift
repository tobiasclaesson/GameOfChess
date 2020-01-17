//
//  GameView.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class GameView: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
