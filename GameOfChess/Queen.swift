//
//  Queen.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class Queen: UIChessPiece {
    init(frame: CGRect, color: UIColor, vc: GameView) {
        super.init(frame: frame)
        
        if color == UIColor.black {
            self.text = "♛"
        }
        else{
            self.text = "♕"
        }
        
        //Makes pawn be drawn on top of tile
        self.isOpaque = false
        //Color of piece
        self.textColor = color
        //Lets user drag and drop
        self.isUserInteractionEnabled = true
        
        self.textAlignment = .center
        self.font = self.font.withSize(38)
        
        //add piece to array
        vc.chessPieces.append(self)
        //add to view
        vc.view.addSubview(self)
        
    }
    
    
    
    
    
    // ??
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
