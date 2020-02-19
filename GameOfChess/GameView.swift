//
//  GameView.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class GameView: UIViewController {
    
    @IBOutlet weak var displayTurnLabel: UILabel!
    @IBOutlet weak var displayCheckLabel: UILabel!
    
    @IBOutlet var panOUTLET: UIPanGestureRecognizer!
    var pieceDragged: UIChessPiece!
    //Source coordinates of topleft point
    var sourceOrigin: CGPoint!
    //Dest coordinates of topleft point
    var destinationOrigin: CGPoint!
    //Space between edge and chess board
    static var SPACE_FROM_LEFT_EDGE = 23
    //Space between top and chess board
    static var SPACE_FROM_TOP_EDGE = 264
    static var TILE_SIZE = 46
    
    var playerOneName = ""
    var playerTwoName = ""

    var myChessGame: ChessGame!
    var chessPieces: [UIChessPiece]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chessPieces = []
        myChessGame = ChessGame.init(viewController: self)
        
    }
    //Touch on screen has began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // If type cast to UIChessPiece fail, pieceDragged will be nil
        pieceDragged = touches.first!.view as? UIChessPiece
        
        if pieceDragged != nil{
            //Origin == top left point of a rect
            sourceOrigin = pieceDragged.frame.origin
        }
    }
    
    //A piece is currently being dragged
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pieceDragged != nil{
            drag(piece: pieceDragged, usingGestureRecognizer: panOUTLET)
        }
    }
    
    //Check if drag is valid
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pieceDragged != nil {
            //Holds the coordinate of where the piece is when the drag has ended.
            let touchLocation = touches.first!.location(in: view)
            
            //Takes x and y coords from touchLocation
            var x = Int(touchLocation.x)
            var y = Int(touchLocation.y)
            
            // Remove constants
            x -= GameView.SPACE_FROM_LEFT_EDGE
            y -= GameView.SPACE_FROM_TOP_EDGE
            
            //Round up
            x = (x / GameView.TILE_SIZE) * GameView.TILE_SIZE
            y = (y / GameView.TILE_SIZE) * GameView.TILE_SIZE
            
            // Add constants
            x += GameView.SPACE_FROM_LEFT_EDGE
            y += GameView.SPACE_FROM_TOP_EDGE
            
            destinationOrigin = CGPoint(x: x, y: y)
            
            let sourceIndex = Chessboard.indexOf(origin: sourceOrigin)
            let destIndex = Chessboard.indexOf(origin: destinationOrigin)
            
            
            
            // If move is valid: set frame origin to destination, else set it back to source origin
            if myChessGame.isMoveValid(piece: pieceDragged, fromIndex: sourceIndex, toIndex: destIndex){
                myChessGame.move(piece: pieceDragged, fromIndex: sourceIndex, toIndex: destIndex, toOrigin: destinationOrigin)
                
                //check if some1 won
                if myChessGame.isGameOver(){
                    displayWinner()
                    return
                }
                
                displayCheck()
                
                myChessGame.nextTurn()
                updateTurnLabel()
            }
            else{
                pieceDragged.frame.origin = sourceOrigin
            }
        }
    }
    
    func displayCheck(){
        guard let playerChecked = myChessGame.getPlayerChecked() else {
            displayCheckLabel.text = nil
            return
        }
        
        displayCheckLabel.text = playerChecked + " is in check"
    }
    
    func displayWinner(){
        if let winner = myChessGame.winner{
            let winnerBox = UIAlertController(title: "Game Over", message: "\(winner) won", preferredStyle: .alert)
            
            winnerBox.addAction(UIAlertAction(title: "Back to main menu", style: .default, handler: {
                action in
                //set up seg to main menu !!!!!!!!!!!!!!!!!!!!!!
                //self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
            }))
            
            winnerBox.addAction(UIAlertAction(title: "Rematch", style: .default, handler: {
                action in
                //Clear screen, pieces array, board matrix
                for chessPiece in self.chessPieces{
                    self.myChessGame.chessBoard.remove(piece: chessPiece)
                }
                
                //Create new game
                self.myChessGame = ChessGame(viewController: self)
                
                //Update labels with game status
                self.updateTurnLabel()
                self.displayCheckLabel.text = nil
                
                
            }))
            
            self.present(winnerBox, animated: true, completion: nil)
        }
    }
    
    func updateTurnLabel(){
        if myChessGame.isWhiteTurn{
            displayTurnLabel.text = "White's turn!"
            displayTurnLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
        else {
            displayTurnLabel.text = "Black's turn"
            displayTurnLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func drag(piece: UIChessPiece, usingGestureRecognizer gestureRecognizer: UIPanGestureRecognizer){
        
        let translation = gestureRecognizer.translation(in: view)
        
        // set new center, old coordninate + pan length
        piece.center = CGPoint(x: translation.x + piece.center.x, y: translation.y + piece.center.y)
        
        // makes sure that the peice stays on our finger when we drag it
        gestureRecognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
