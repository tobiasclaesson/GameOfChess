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
    var winner: String?
    
    init(viewController: GameView) {
        chessBoard = Chessboard.init(viewController: viewController)
    }
    
    func getPawnToBePromoted() -> Pawn? {
        for chessPiece in chessBoard.vc.chessPieces{
            //check all pawns in the array
            if let pawn = chessPiece as? Pawn{
                //get index of the pawn
                let pawnIndex = Chessboard.indexOf(origin: pawn.frame.origin)
                //Check if the pawn is on the first or last row of the board
                if pawnIndex.row == 0 || pawnIndex.row == 7{
                    return pawn
                }
            }
        }
        return nil
    }
    
    func getPlayerChecked() -> String?{
        guard let whiteKingIndex = chessBoard.getIndex(forChessPiece: chessBoard.whiteKing) else {return nil}
        guard let blackKingIndex = chessBoard.getIndex(forChessPiece: chessBoard.blackKing) else {return nil}
        
        //check every chesspiece on the board if it can attack the kings
        for row in 0..<chessBoard.ROWS{
            for col in 0..<chessBoard.COLS{
                if let chessPiece = chessBoard.board[row][col] as? UIChessPiece{
                    
                    let chessPieceIndex = BoardIndex(row: row, col: col)
                    
                    //check attacks towards white king
                    if chessPiece.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                        if IsNormalMoveValid(forPiece: chessPiece, fromIndex: chessPieceIndex, toIndex: whiteKingIndex){
                            return "White"
                        }
                    }
                    //Check attacks towards black king
                    else{
                        if IsNormalMoveValid(forPiece: chessPiece, fromIndex: chessPieceIndex, toIndex: blackKingIndex){
                            return "Black"
                        }
                    }
                }
            }
        }
        //return nil if no1 is under check
        return nil
    }
    
    func isGameOver() -> Bool {
        
        if didSomebodyWin() {
            return true
        }
        
        return false
        
    }
    
    func didSomebodyWin() -> Bool {
        
        //check if white king is alive
        if !chessBoard.vc.chessPieces.contains(chessBoard.whiteKing){
            winner = "Black"
            return true
        }
        
        //check if black king is alive
        if !chessBoard.vc.chessPieces.contains(chessBoard.blackKing){
            winner = "White"
            return true
        }
        
        return false
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
        //Not attacking
        if source.col == dest.col{
            
            //Advance by 2
            if pawn.triesToAdvanceBy2{
                var moveForward = 0
                
                
                if pawn.color == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                    moveForward = 1
                }
                else{
                    moveForward = -1
                }
                //Checks if path is Ghosts
                if chessBoard.board[dest.row][dest.col] is Ghost && chessBoard.board[dest.row - moveForward][dest.col] is Ghost{
                    return true
                }
            }
            //Advance by 1
            else{
                if chessBoard.board[dest.row][dest.col] is Ghost{
                    return true
                }
            }
        }
        //Attacking
        else{
            
            //Checks that destination contains anything but i Ghost piece
            if !(chessBoard.board[dest.row][dest.col] is Ghost){
                return true
            }
        }
        
        return false
    }
    
    func isMoveValid(forRookOrBishopOrQueen piece: UIChessPiece, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        switch piece{
        case is Rook:
            if let rook = piece as? Rook{
                if !rook.doesMoveSeemFine(fromIndex: source, toIndex: dest){
                    return false
                }
            }
        case is Bishop:
            if let bishop = piece as? Bishop{
                if !bishop.doesMoveSeemFine(fromIndex: source, toIndex: dest){
                    return false
                }
            }
        default:
            if let queen = piece as? Queen{
                if !queen.doesMoveSeemFine(fromIndex: source, toIndex: dest){
                    return false
                }
            }
        }
        
        var increaseRow = 0
        //Check that difference in rows is not 0
        if dest.row - source.row != 0{
            //sets increse row to 1 or -1 depending on direction
            increaseRow = (dest.row - source.row) / abs(dest.row - source.row)
        }
        
        var increaseCol = 0
        
        if dest.col - source.col != 0{
            increaseCol = (dest.col - source.col) / abs(dest.col - source.col)
        }
        
        var nextRow = source.row + increaseRow
        var nextCol = source.col + increaseCol
        
        //loop until nextRow and nextCol == dest row and col
        //Checks if path is clear
        while nextRow != dest.row || nextCol != dest.col{
            if !(chessBoard.board[nextRow][nextCol] is Ghost){
                return false
            }
            nextRow += increaseRow
            nextCol += increaseCol
        }
        
        return true
    }
    
    func isMoveValid(forKing king: King, fromIndex source: BoardIndex, toIndex dest: BoardIndex) -> Bool {
        
        if !king.doesMoveSeemFine(fromIndex: source, toIndex: dest){
            return false
        }
        
        if isOpponentKing(nearKing: king, thatGoesTo: dest){
            return false
        }
        
        return true
    }
    
    func isOpponentKing(nearKing movingKing: King, thatGoesTo destIndexOfMovingKing: BoardIndex) -> Bool {
        
        var opponentKing: King
        
        //opponentKing == the not moving king
        if movingKing == chessBoard.whiteKing{
            opponentKing = chessBoard.blackKing
        }
        else{
            opponentKing = chessBoard.whiteKing
        }
        
        var index: BoardIndex?
        
        
        //Find opponentKing on the board, get the index
        for row in 0..<chessBoard.ROWS{
            for col in 0..<chessBoard.COLS{
                if let king = chessBoard.board[row][col] as? King, king == opponentKing{
                    index = BoardIndex(row: row, col: col)
                }
            }
        }
        
        if let indexOfOpponentKing = index as? BoardIndex{
        
            //Get absoulute difference between kings
            let diffInRows = abs(indexOfOpponentKing.row - destIndexOfMovingKing.row)
            let diffInCols = abs(indexOfOpponentKing.col - destIndexOfMovingKing.col)
            
            //If they are to close, then move is invalid
            if case 0...1 = diffInRows{
                if case 0...1 = diffInCols{
                    return true
                }
            }
        }
        
        return false
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
