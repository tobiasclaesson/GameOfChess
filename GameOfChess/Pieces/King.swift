//
//  King.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class King: UIChessPiece {
    init(frame: CGRect, color: UIColor, vc: GameView) {
        super.init(frame: frame)
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
            self.text = "♚"
        }
        else{
            self.text = "♔"
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
    
    func tryToMove(fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        
        let diffInRows = abs(dest.row - source.row)
        let diffInCols = abs(dest.col - source.col)
        
        //return true if moving between 0 to 1 units in row or/ and col
        if case 0...1 = diffInRows{
            if case 0...1 = diffInCols{
                return true
            }
        }
        return false
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
