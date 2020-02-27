//
//  ExtensionUIVC.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-02-27.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func HideKeyBoard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
}
