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
    
    @IBOutlet weak var textField: UITextField!
    
    var whitePlayerName = ""
    var blackPlayerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.setGradientBackground(firstColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
    }
    @IBAction func confirmButtonClick(_ sender: Any) {
        
       guard let name = textField.text else {return}
        
        if textField.text == ""{
            blackPlayerName = "Anonymous"
        }
        else{
            blackPlayerName = name
        }
        
        performSegue(withIdentifier: segueToGameView, sender: self)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueToGameView{
            guard let destVC = segue.destination as? GameView else {return}
            
            destVC.whitePlayerName = self.whitePlayerName
            destVC.blackPlayerName = self.blackPlayerName
        }
    }
}
