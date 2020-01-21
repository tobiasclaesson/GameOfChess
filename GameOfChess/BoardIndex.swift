//
//  BoardIndex.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation

struct BoardIndex: Equatable {
    
    var row: Int
    var col: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    //Compare to see if BoardIndexes are equal
    static func ==(leftHandSide: BoardIndex, rightHandSide: BoardIndex) -> Bool{
        return (leftHandSide.row == rightHandSide.row && leftHandSide.col == rightHandSide.col)
    }
}
