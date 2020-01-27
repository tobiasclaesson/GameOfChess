//
//  ChessGame.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class ChessGame: NSObject {
    
    var chessBoard: Chessboard!
    
    init(viewController: GameView) {
        chessBoard = Chessboard.init(viewController: viewController)
    }
    
    func isMoveValid(piece: UIChessPiece, fromIndex sourceIndex: BoardIndex, toIndex destIndex: BoardIndex) -> Bool{
        
        
        
        return false
    }
}
