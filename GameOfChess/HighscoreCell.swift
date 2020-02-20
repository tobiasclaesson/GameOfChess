//
//  HighscoreCell.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-02-20.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class HighscoreCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //setGradientBackground(firstColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        //self.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 0)
        //self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
