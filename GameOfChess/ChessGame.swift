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
    
    func move(piece chessPieceToMove: UIChessPiece, fromIndex sourceIndex: BoardIndex, toIndex destIndex: BoardIndex, toOrigin destOrigin: CGPoint){
        
        //get initial chess piece frame
        let initialChessPieceFrame = chessPieceToMove.frame
        
        //remove piece at destination
        let pieceToRemove = chessBoard.board[destIndex.row][destIndex.col]
        chessBoard.remove(piece: pieceToRemove)
        
        //place the piece at destination
        chessBoard.place(chessPiece: chessPieceToMove, toIndex: destIndex, toOrigin: destOrigin)
        
        //put ghost in the source frame
        chessBoard.board[sourceIndex.row][sourceIndex.col] = Ghost(frame: initialChessPieceFrame)
    }
    
    func isMoveValid(piece: UIChessPiece, fromIndex sourceIndex: BoardIndex, toIndex destIndex: BoardIndex) -> Bool{
        
        guard isMoveOnBoard(forPieceFrom: sourceIndex, thatGoesTo: destIndex) else {
            print("Move is not on board")
            return false
        }
        
        
        
        return true
    }
    
    func isMoveOnBoard(forPieceFrom sourceIndex: BoardIndex, thatGoesTo destIndex: BoardIndex) -> Bool {
        if case 0..<chessBoard.ROWS = sourceIndex.row{
            if case 0..<chessBoard.COLS = sourceIndex.col{
                if case 0..<chessBoard.ROWS = destIndex.row{
                    if case 0..<chessBoard.COLS = destIndex.col{
                        return true
                    }
                }
            }
        }
        return false
    }
    
}
