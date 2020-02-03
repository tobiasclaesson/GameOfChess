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
    
    func remove(piece: Piece){
        if let chessPiece = piece as? UIChessPiece{
            //remove from board
            let indexOnBoard = Chessboard.indexOf(origin: chessPiece.frame.origin)
            board[indexOnBoard.row][indexOnBoard.col] = Ghost(frame: chessPiece.frame)
            
            //remove from array of chessPieces
            if let indexInChessPieceArray = vc.chessPieces.firstIndex(of: chessPiece){
                vc.chessPieces.remove(at: indexInChessPieceArray)
            }
            
            //remove from the the screen
            chessPiece.removeFromSuperview()
            
        }
    }
    
    func place(chessPiece: UIChessPiece, toIndex destIndex: BoardIndex, toOrigin destOrigion: CGPoint){
        
        chessPiece.frame.origin = destOrigion
        board[destIndex.row][destIndex.col] = chessPiece
        
    }
    
    static func indexOf(origin: CGPoint) -> BoardIndex {
        let row = (Int(origin.y) - GameView.SPACE_FROM_TOP_EDGE) / GameView.TILE_SIZE
        let col = (Int(origin.x) - GameView.SPACE_FROM_LEFT_EDGE) / GameView.TILE_SIZE
        
        return BoardIndex(row: row, col: col)
    }
    
    //Return a frame of a specific index (Kind of a chessboard but in logic instead of graphic)
    static func getFrame(forRow row: Int, forCol col: Int) -> CGRect{
        let x = CGFloat(GameView.SPACE_FROM_LEFT_EDGE + (col * GameView.TILE_SIZE))
        let y = CGFloat(GameView.SPACE_FROM_TOP_EDGE + (row * GameView.TILE_SIZE))
        
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: GameView.TILE_SIZE, height: GameView.TILE_SIZE))
    }
    
    // Initiate a chessboard with all the pieces placed on the screen.
    init(viewController: GameView) {
        vc = viewController
        
        //init the 2d board with ghosts
        let oneRowOfBoard = Array(repeating: Ghost(), count: COLS)
        board = Array.init(repeating: oneRowOfBoard, count: ROWS)
        
        // Initiate board with correct pieces, put Ghosts on spots where there is no piece.
        for row in 0..<ROWS{
            for col in 0..<COLS{
                switch row {
                case 0:
                    switch col {
                    case 0:
                        board[row][col] = Rook(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 1:
                        board[row][col] = Knight(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 2:
                        board[row][col] = Bishop(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 3:
                        board[row][col] = Queen(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 4:
                        blackKing = King(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                        
                        board[row][col] = blackKing
                    case 5:
                        board[row][col] = Bishop(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    case 6:
                        board[row][col] = Knight(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    default:
                        board[row][col] = Rook(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                        
                    }
                case 1:
                    board[row][col] = Pawn(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), vc: vc)
                    
                case 6:
                    board[row][col] = Pawn(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                case 7:
                    switch col {
                    case 0:
                        board[row][col] = Rook(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 1:
                        board[row][col] = Knight(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 2:
                        board[row][col] = Bishop(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 3:
                        board[row][col] = Queen(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 4:
                        whiteKing = King(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                        
                        board[row][col] = whiteKing
                    case 5:
                        board[row][col] = Bishop(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    case 6:
                        board[row][col] = Knight(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    default:
                        board[row][col] = Rook(frame: Chessboard.getFrame(forRow: row, forCol: col), color: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), vc: vc)
                    }
                default:
                    board[row][col] = Ghost(frame: Chessboard.getFrame(forRow: row, forCol: col))
                }
            }
        }
    }
}
