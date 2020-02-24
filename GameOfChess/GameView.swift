//
//  GameView.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GameView: UIViewController {
    
    var db : Firestore!
    
    let segToMain = "unwindToMainMenu"
    
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
    
    var playerOneName = "TestPlayer1"
    var playerTwoName = "TestPlayer2"
    var players = [String]()
    var currentPlayer = ""
    var moves = 0

    var myChessGame: ChessGame!
    var chessPieces: [UIChessPiece]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(firstColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        chessPieces = []
        myChessGame = ChessGame.init(viewController: self)
        players = [playerOneName, playerTwoName]
        currentPlayer = playerOneName
        
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
                
                if pieceDragged.color != #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                    moves += 1
                }
                
                //check if some1 won
                if myChessGame.isGameOver(){
                    displayWinner()
                    return
                }
                
                if shouldPromotePawn(){
                    promptForPawnPromotion()
                }
                else{
                    
                    resumeGame(piece: pieceDragged)
                }
                
                
            }
            else{
                pieceDragged.frame.origin = sourceOrigin
            }
        }
    }
    
    func resumeGame(piece: UIChessPiece){
        //display check if there are any
        displayCheck()
        
        for player in players{
            if player != currentPlayer{
                currentPlayer = player
                break
            }
        }
        myChessGame.nextTurn()
        updateTurnLabel()
    }
    
    func promote(pawn pawnToBePromoted: Pawn, into option: String){
        
    }
    
    func promptForPawnPromotion(){
        
    }
    
    func shouldPromotePawn() -> Bool {
        if myChessGame.getPawnToBePromoted() != nil{
            return true
        }
        else {
            return false
        }
    }
    
    func displayCheck(){
        guard let playerChecked = myChessGame.getPlayerChecked() else {
            displayCheckLabel.text = nil
            return
        }
        
        displayCheckLabel.text = playerChecked + " are in Check!"
    }
    
    func displayWinner(){
        if let winner = myChessGame.winner{
            
            addHighscoreToDB()
            
            let winnerBox = UIAlertController(title: "Game Over", message: "\(winner) won", preferredStyle: .alert)
            
            winnerBox.addAction(UIAlertAction(title: "Back to main menu", style: .default, handler: {
                action in
                //perform seg to main menu
                self.performSegue(withIdentifier: self.segToMain, sender: self)
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
            displayTurnLabel.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        else {
            displayTurnLabel.text = "Black's turn"
            displayTurnLabel.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
    }
    
    func drag(piece: UIChessPiece, usingGestureRecognizer gestureRecognizer: UIPanGestureRecognizer){
        
        let translation = gestureRecognizer.translation(in: view)
        
        // set new center, old coordninate + pan length
        piece.center = CGPoint(x: translation.x + piece.center.x, y: translation.y + piece.center.y)
        
        // makes sure that the peice stays on our finger when we drag it
        gestureRecognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    func addHighscoreToDB(){
        db = Firestore.firestore()
        
        let itemRef = db.collection("highscores")
        
        let highscore = Highscore(playerName: currentPlayer, numberOfMoves: moves)
        
        itemRef.addDocument(data: highscore.toDict())
    }
    
    
    @IBAction func quitButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.segToMain, sender: self)
    }
}
