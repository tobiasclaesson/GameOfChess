//
//  Highscore.swift
//  GameOfChess
//
//  Created by Tobias Classon on 2020-02-20.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import Firebase

struct Highscore{
    var playerName: String
    var numberOfMoves: Int
    
    init(playerName: String, numberOfMoves: Int){
        self.playerName = playerName
        self.numberOfMoves = numberOfMoves
    }
    
    init (snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String : Any]
        playerName = snapshotValue["playerName"] as! String
        numberOfMoves = snapshotValue["moves"] as! Int
        
    }
    
    func toDict() -> [String : Any] {
        return ["playerName" : playerName,
                "moves" : numberOfMoves]
    }
    
}
