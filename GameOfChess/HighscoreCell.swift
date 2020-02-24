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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
