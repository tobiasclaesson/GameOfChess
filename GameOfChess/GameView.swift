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
    var piecePanned: UIChessPiece!
    //Source coordinates of topleft point
    var sourceOrigin: CGPoint!
    //Dest coordinates of topleft point
    var destinationOrigin: CGPoint!
    //Space between edge and chess board
    static var SPACE_FROM_LEFT_EDGE = 8
    //Space between top and chess board
    static var SPACE_FROM_TOP_EDGE = 264
    static var TILE_SIZE = 46

    var myChessGame: ChessGame!
    var chessPieces: [UIChessPiece]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
