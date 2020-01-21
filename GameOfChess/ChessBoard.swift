//
//  ChessBoard.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit

class Chessboard: NSObject {
    var board: [[Piece]]!
    var vc: GameView!
    let ROWS = 8
    let COLS = 8
    var whiteKing: King!
    var blackKing: King!
    
    //Video part 3 Gets a specific frame on the board?
    func getFrame(forRow row: Int, forCol col: Int) -> CGRect{
        let x = CGFloat(GameView.SPACE_FROM_LEFT_EDGE + col * GameView.TILE_SIZE)
        let y = CGFloat(GameView.SPACE_FROM_TOP_EDGE + row * GameView.TILE_SIZE)
        
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: GameView.TILE_SIZE, height: GameView.TILE_SIZE))
    }
    
    init(viewController: GameView) {
        vc = viewController
        
        //init the 2d board with ghosts
        let oneRowOfBoard = Array(repeating: Ghost(), count: COLS)
        board = Array.init(repeating: oneRowOfBoard, count: ROWS)
    }
}
