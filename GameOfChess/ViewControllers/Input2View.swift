//
//  Input2View.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-01-17.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import UIKit

class Input2View: UIViewController {
    
    let segueToGameView = "segueToGameView"
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var labelUnderlineView: UIView!
    @IBOutlet weak var textFieldUnderlineWidthConstrain: NSLayoutConstraint!
    
    var whitePlayerName = ""
    var blackPlayerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldLabel.alpha = 0
        self.textFieldUnderlineWidthConstrain.constant = 0
        labelUnderlineView.frame.size.width = 0
        styleTextField(textFieldToStyle: textField)
        view.setGradientBackground(firstColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
    }
    
    func styleTextField(textFieldToStyle textField: UITextField){
        textField.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        let bottomLine = CALayer()
        
        //Bottom line
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        //Remove border
        textField.borderStyle = .none
        
        //Add the line to the textField
        textField.layer.addSublayer(bottomLine)
        
        //Placeholder
        textField.attributedPlaceholder = createAttributedString(text: "Write name here", textColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.8))
        
    }
    
    func createAttributedString(text: String, textColor: UIColor, font: UIFont = UIFont(name: "Kefa", size: 16.0)!) -> NSMutableAttributedString{
        var myMutableStringTitle = NSMutableAttributedString()
        let string  = text // PlaceHolderText
        myMutableStringTitle = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: font]) // Font
        myMutableStringTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range:NSRange(location: 0,length: string.count))    // Color
        return myMutableStringTitle
    }
    
    func animateUnderline(){
        UIView.animate(withDuration: 0.5, animations: {
            self.textFieldUnderlineWidthConstrain.constant = 70
            self.labelUnderlineView.frame.size.width = 70
        })
    }

    @IBAction func textFieldEditBegan(_ sender: Any) {
        textField.attributedPlaceholder = createAttributedString(text: "", textColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.8))
        
        UIView.animate(withDuration: 1, animations: {
            self.textFieldLabel.alpha = 1}, completion: {
                (finished: Bool) in
                
                self.animateUnderline()
                
                
        })
    }
    @IBAction func textFieldEditEnded(_ sender: Any) {
        if textField.text == ""{
            textField.attributedPlaceholder = createAttributedString(text: "Write name here", textColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.8))
        }
        
       UIView.animate(withDuration: 1, animations: {
            self.labelUnderlineView.frame.size.width = 0
            self.textFieldLabel.alpha = 0
        })
    }
    
    
    
    @IBAction func confirmButtonClick(_ sender: Any) {
        
       guard let name = textField.text else {return}
        
        if textField.text == ""{
            blackPlayerName = "Anonymous"
        }
        else{
            blackPlayerName = name
        }
        
        performSegue(withIdentifier: segueToGameView, sender: self)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueToGameView{
            guard let destVC = segue.destination as? GameView else {return}
            
            destVC.whitePlayerName = self.whitePlayerName
            destVC.blackPlayerName = self.blackPlayerName
        }
    }
}
