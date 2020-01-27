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
        
    }
    
    func drag(piece: UIChessPiece, usingGestureRecognizer gestureRecognizer: UIPanGestureRecognizer){
        
        let translation = gestureRecognizer.translation(in: view)
        
        // set new center, old coordninate + pan length
        piece.center = CGPoint(x: translation.x + piece.center.x, y: translation.y + piece.center.y)
        
        // Video 4, makes sure that the peice stays on our finger when we drag it
        gestureRecognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
