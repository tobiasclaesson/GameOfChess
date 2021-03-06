//
//  Knight.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class Knight: UIChessPiece {
    init(frame: CGRect, color: UIColor, vc: GameView) {
        super.init(frame: frame)
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
            self.text = "♞"
        }
        else{
            self.text = "♘"
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
        //Array with all valid moves
        let validMoves = [(source.row - 1, source.col + 2),
                          (source.row - 2, source.col + 1),
                          (source.row - 2, source.col - 1),
                          (source.row - 1, source.col - 2),
                          (source.row + 1, source.col - 2),
                          (source.row + 2, source.col - 1),
                          (source.row + 2, source.col + 1),
                          (source.row + 1, source.col + 2)]
        
        for (validRow, validCol) in validMoves{
            if dest.row == validRow && dest.col == validCol{
                return true
            }
        }
        
        return false
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
