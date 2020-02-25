//
//  Ghost.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class Ghost: Piece {
    private var xStorage: CGFloat!
    private var yStorage: CGFloat!
    
    var x: CGFloat{
        get{
            return self.xStorage
        }
        set{
            self.xStorage = newValue
        }
    }
    var y: CGFloat{
        get{
            return self.yStorage
        }
        set{
            self.yStorage = newValue
        }
    }
    
    init(frame: CGRect) {
        self.xStorage = frame.origin.x
        self.yStorage = frame.origin.y
    }
    
    init(){
        
    }

}
