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
    
    @IBOutlet weak var tileView: UIView!
    @IBOutlet var wholeView: UIView!
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
    static var SPACE_FROM_LEFT_EDGE : Int = Int((UIScreen.main.bounds.width - (40 * 8)) * 0.5)
    //Space between top and chess board
    static var SPACE_FROM_TOP_EDGE: Int = Int((UIScreen.main.bounds.height - (40 * 8)) * 0.5)
    //Tile size
    static var TILE_SIZE = 40
    
    var whitePlayerName = ""
    var blackPlayerName = ""
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
        players = [whitePlayerName, blackPlayerName]
        currentPlayer = whitePlayerName
        
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
            let x = Int(touchLocation.x)
            let y = Int(touchLocation.y)
            
            //Round down to closest chess tile
            destinationOrigin = roundToClosestTile(fromX: x, fromY: y)
            
            //Get Row and col for source and dest origin
            let sourceIndex = Chessboard.indexOf(origin: sourceOrigin)
            let destIndex = Chessboard.indexOf(origin: destinationOrigin)
            
            
            
            // If move is valid: set frame origin to destination, else set it back to source origin
            if myChessGame.isMoveValid(piece: pieceDragged, fromIndex: sourceIndex, toIndex: destIndex){
                myChessGame.move(piece: pieceDragged, fromIndex: sourceIndex, toIndex: destIndex, toOrigin: destinationOrigin)
                print(currentPlayer + " moved")
                
                //Increase moves variable every time white moves
                if pieceDragged.color != #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
                    moves += 1
                }
                
                //check if some1 won
                if myChessGame.isGameOver(){
                    displayWinner()
                    return
                }
                
                //Check if there is a pawn on the last or first row
                if shouldPromotePawn(){
                    //Promote pawn
                    promptForPawnPromotion()
                    resumeGame(piece: pieceDragged)
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
        
        //Change current player
        for player in players{
            if player != currentPlayer{
                currentPlayer = player
                break
            }
        }
        myChessGame.nextTurn()
        updateTurnLabel()
    }
    
    func promote(pawn pawnPromoted: Pawn, into optionPiece: String){
        let pawnColor = pawnPromoted.color
        let pawnFrame = pawnPromoted.frame
        
        //Get index of the pawn that will be promoted
        let pawnIndex = Chessboard.indexOf(origin: pawnFrame.origin)
        
        myChessGame.chessBoard.remove(piece: pawnPromoted)
        
        //Create a new piece depending on what the player choose at the pawns old location
        switch optionPiece {
        case "Queen":
            myChessGame.chessBoard.board[pawnIndex.row][pawnIndex.col] = Queen(frame: pawnFrame, color: pawnColor, vc: self)
        case "Knight":
            myChessGame.chessBoard.board[pawnIndex.row][pawnIndex.col] = Knight(frame: pawnFrame, color: pawnColor, vc: self)
        case "Bishop":
            myChessGame.chessBoard.board[pawnIndex.row][pawnIndex.col] = Bishop(frame: pawnFrame, color: pawnColor, vc: self)
        case "Rook":
            myChessGame.chessBoard.board[pawnIndex.row][pawnIndex.col] = Rook(frame: pawnFrame, color: pawnColor, vc: self)
        default:
            break
        }
            
        
    }
    
    func promptForPawnPromotion(){
        if let pawn = myChessGame.getPawnToBePromoted(){
            
            let alertBox = UIAlertController(title: "Pawn promoted!", message: "Choose new piece", preferredStyle: UIAlertController.Style.alert)
            
            alertBox.addAction(UIAlertAction(title: "Queen", style: .default, handler: {
                action in
                self.promote(pawn: pawn, into: "Queen")
            }))
            alertBox.addAction(UIAlertAction(title: "Knight", style: .default, handler: {
                action in
                self.promote(pawn: pawn, into: "Knight")
            }))
            alertBox.addAction(UIAlertAction(title: "Bishop", style: .default, handler: {
                action in
                self.promote(pawn: pawn, into: "Bishop")
            }))
            alertBox.addAction(UIAlertAction(title: "Rook", style: .default, handler: {
                action in
                self.promote(pawn: pawn, into: "Rook")
            }))
            
            
            self.present(alertBox, animated: true, completion: nil)
        }
        
        
        
    }
    
    func shouldPromotePawn() -> Bool {
        if myChessGame.getPawnToBePromoted() != nil{
            return true
        }
        else {
            return false
        }
    }
    
    func roundToClosestTile(fromX x: Int, fromY y: Int) -> CGPoint{
        
        var xx = x
        
        var yy = y
        
        // Remove constants
        xx -= GameView.SPACE_FROM_LEFT_EDGE
        yy -= GameView.SPACE_FROM_TOP_EDGE
        
        
        //Round down to closest tile origin
        xx = (x / GameView.TILE_SIZE) * GameView.TILE_SIZE
        yy = (y / GameView.TILE_SIZE) * GameView.TILE_SIZE
        
        
        // Add constants
        xx += GameView.SPACE_FROM_LEFT_EDGE
        yy += GameView.SPACE_FROM_TOP_EDGE
        
        
        return CGPoint(x: xx, y: yy)
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
            
            let winnerBox = UIAlertController(title: "Game Over", message: "\(currentPlayer)/ \(winner) player won in \(moves) moves!", preferredStyle: .alert)
            
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
