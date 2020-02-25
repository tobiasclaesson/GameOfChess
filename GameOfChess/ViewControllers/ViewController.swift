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
    
    @IBOutlet weak var playGameButtonView: UIView!
    @IBOutlet weak var highscoreButtonView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        styleButtonView(buttonIdentifier: playGameButtonView)
        styleButtonView(buttonIdentifier: highscoreButtonView)
       
        
        
        
    }

    @IBAction func playButtonClick(_ sender: Any) {
        performSegue(withIdentifier: segueToInput1View, sender: self)
    }
    
    @IBAction func highscoreButtonClick(_ sender: Any) {
        performSegue(withIdentifier: segueToHighscoreView, sender: self)
    }
    
    
    func styleButtonView(buttonIdentifier button: UIView){
//        button.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        button.setGradientBackground(firstColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1), secondColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.8))
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue){
        
    }
    
}

