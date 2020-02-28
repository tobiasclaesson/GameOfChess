//
//  Pawn.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class Pawn: UIChessPiece {
    
    var triesToAdvanceBy2: Bool = false
    
    init(frame: CGRect, color: UIColor, vc: GameView) {
        super.init(frame: frame)
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
            self.text = "♟"
        }
        else{
            self.text = "♙"
        }
        
        //Makes pawn be drawn on top of tile
        self.isOpaque = false
        //Color of piece
        self.textColor = color
        //Lets user drag and drop
        self.isUserInteractionEnabled = true
        
        self.textAlignment = .center
        self.font = self.font.withSize(35)
        
        //add piece to array
        vc.chessPieces.append(self)
        //add to view
        vc.view.addSubview(self)
        
    }
    
    //Pawn walking pattern. Does not care about the state of the board.
    func tryToMove(fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        //check advance by 2
        if source.col == dest.col{
            if (source.row == 1 && dest.row == 3 && color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) || (source.row == 6 && dest.row == 4 && color != #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)){
                triesToAdvanceBy2 = true
                return true
            }
        }
        
        triesToAdvanceBy2 = false
        
        //check advance by 1
        var moveForward = 0
        
        //for a black piece a move forward is an increase in row number
        //for a white piece a move forward is a decrease in row number
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
            moveForward = 1
        } else {
            moveForward = -1
        }
        
        //checks if it is an advance by 1
        if dest.row == source.row + moveForward{
            // checks if dest col is straight forward or +/- 1
            if (dest.col == source.col - 1) || (dest.col == source.col) || (dest.col == source.col + 1){
                return true
            }
        }
        
        return false
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
