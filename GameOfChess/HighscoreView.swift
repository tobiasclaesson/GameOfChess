//
//  HighscoreView.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-02-20.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class HighscoreView: UIViewController, UITableViewDataSource {
    
    let cellId = "highscoreCellId"
    
    @IBOutlet weak var highscoreTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.setGradientBackground(firstColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        let nib = UINib(nibName: "HighscoreCell", bundle: nil)
        
        highscoreTableView.register(nib, forCellReuseIdentifier: cellId)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HighscoreCell
        
        cell.movesLabel.text = "2"
        cell.nameLabel.text = "Tobias"
        cell.numberLabel.text = "1"
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
