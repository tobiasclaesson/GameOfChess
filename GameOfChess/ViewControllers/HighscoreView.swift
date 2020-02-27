//
//  HighscoreView.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-02-20.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import UIKit
import Firebase

class HighscoreView: UIViewController, UITableViewDataSource {
    
    var db : Firestore!
    
    let cellId = "highscoreCellId"
    
    @IBOutlet weak var highscoreTableView: UITableView!
    
    var highscores = [Highscore]()
    var sortedHighscores = [Highscore]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //readFromDB()
        
        db = Firestore.firestore()
        
        highscoreTableView.rowHeight = UITableView.automaticDimension
        highscoreTableView.estimatedRowHeight = 70
        
        let itemRef = db.collection("highscores")
        
        itemRef.addSnapshotListener() {
            (snapshot , error) in
            guard let documents = snapshot?.documents else {return}
            
            for document in documents {
                let highscore = Highscore(snapshot: document)
                
                self.highscores.append(highscore)
                
                //print(item.name)
            }
            self.sortedHighscores = self.highscores.sorted()
            
            self.highscoreTableView.reloadData()
        }

        view.setGradientBackground(firstColor: #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), secondColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        let nib = UINib(nibName: "HighscoreCell", bundle: nil)
        
        highscoreTableView.register(nib, forCellReuseIdentifier: cellId)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        highscores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HighscoreCell
        
//        for highscore in highscores{
//
//        }
        
        cell.movesLabel.text = String(sortedHighscores[indexPath.row].numberOfMoves)
        cell.nameLabel.text = sortedHighscores[indexPath.row].playerName
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
//    func readFromDB(){
//        db = Firestore.firestore()
//
//        let itemRef = db.collection("highscores")
//
//        itemRef.getDocuments() {
//            (snapshot , error) in
//            guard let documents = snapshot?.documents else {return}
//
//            for document in documents {
//                let highscore = Highscore(snapshot: document)
//
//                self.highscores.append(highscore)
//
//                //print(item.name)
//            }
//            
//
//
//        }
//
//
//    }
    
}
