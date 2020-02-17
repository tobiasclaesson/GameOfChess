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
    var isWhiteTurn = true
    
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
        
        guard isTurnColor(sameAsPiece: piece) else {
            print("Wrong turn")
            return false
        }
        
        return IsNormalMoveValid(forPiece: piece, fromIndex: sourceIndex, toIndex: destIndex)
    }
    
    func IsNormalMoveValid(forPiece piece: UIChessPiece, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        guard source != dest else {
            print("Moving piece on current position")
            return false
        }
        
        guard !isAttackingAlliedPiece(sourceChessPiece: piece, destIndex: dest) else {
            print("Attacking Allied Piece")
            return false
        }
        
        switch piece {
        case is Pawn:
            if let pawn = piece as? Pawn{
                return isMoveValid(forPawn: pawn, fromIndex: source, toIndex: dest)
            }
        case is Rook, is Bishop, is Queen:
            return isMoveValid(forRookOrBishopOrQueen: piece, fromIndex: source, toIndex: dest)
        case is Knight:
            if let knight = piece as? Knight{
                if !knight.doesMoveSeemFine(fromIndex: source, toIndex: dest){
                    return false
                }
            }
        case is King:
            if let king = piece as? King{
                return isMoveValid(forKing: king, fromIndex: source, toIndex: dest)
            }
        default:
            break
        }
        
        return true
    }
    
    func isMoveValid(forPawn pawn: Pawn, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        
        if !pawn.doesMoveSeemFine(fromIndex: source, toIndex: dest){
            return false
        }
        
        return true
    }
    
    func isMoveValid(forRookOrBishopOrQueen piece: UIChessPiece, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        
        return true
    }
    
    func isMoveValid(forKing king: King, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        
        return true
    }
    
    
    func isAttackingAlliedPiece(sourceChessPiece: UIChessPiece, destIndex: BoardIndex) -> Bool {
        let destPiece: Piece = chessBoard.board[destIndex.row][destIndex.col]
        
        //Checking to make sure it is a UIChessPiece and not a ghost
        //Can i skip this guard statement?
        guard !(destPiece is Ghost) else {
            return false
        }
        
        if let destChessPiece = destPiece as? UIChessPiece{
            //Return true if colors match
            if sourceChessPiece.color == destChessPiece.color{
                return true
            }
        }
        
        return false
    }
    
    func nextTurn() {
        //sets isWhiteTurn Boool to its opposite
        isWhiteTurn = !isWhiteTurn
    }
    
    func isTurnColor(sameAsPiece piece: UIChessPiece) -> Bool {
        if piece.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
            if !isWhiteTurn{
                return true
            }
        }
        else{
            if isWhiteTurn{
                return true
            }
        }
        return false
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
