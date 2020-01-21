//
//  ExtensionUIChessPiece.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-21.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit
typealias UIChessPiece = UILabel

//UILabel can now be called UIChessPiece and have to match Piece protocol
extension UIChessPiece: Piece {
    // Need x and y value to match Piece protocol
    var x: CGFloat{
        get{
            return self.frame.origin.x //frame = CGRect, Origin is a CGPoint
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    // Easier to refer to a UIChessPiece.color instead of .textcolor
    var color: UIColor{
        get{
            return self.textColor
        }
    }
}
