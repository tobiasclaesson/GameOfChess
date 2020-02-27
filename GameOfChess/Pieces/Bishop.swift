//
//  Bishop.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class Bishop: UIChessPiece {
    init(frame: CGRect, color: UIColor, vc: GameView) {
        super.init(frame: frame)
        
        if color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
            self.text = "♝"
        }
        else{
            self.text = "♗"
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
        //abs makes every value positive
        //Check if difference absolute value of rows == difference in abosulute value in cols == Piece have moved diagonally
        if abs(dest.row - source.row) == abs(dest.col - source.col){
            return true
        }
        
        return false
    }
    
    
    
    // ??
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
