//
//  HideSeekRunner.swift
//  HideAndSeek
//
//  Created by Subhi Sbahi on 6/15/17.
//  Copyright © 2017 Rami Sbahi. All rights reserved.
//

import Foundation

class HideSeekRunner
{
    var myPlayers: [Player] = []
    var currentPlayerIndex = 0
    var currentPlayer: Player = Player(name: "")
    
    init(players: [Player])
    {
        myPlayers = players
        if(myPlayers.count > 0)
        {
        currentPlayer = myPlayers[0]
        }
    }
    
    func nextPlayer()
    {
        if(currentPlayerIndex == myPlayers.count - 1)
        {
            currentPlayerIndex = 0
        }
        else
        {
            currentPlayerIndex += 1
        }
        
        currentPlayer = myPlayers[currentPlayerIndex]
    }
    
    func otherPlayers() -> [Player]
    {
        var others: [Player] = []
        for i in 0..<myPlayers.count
        {
            if(i != currentPlayerIndex)
            {
                others.append(myPlayers[i])
            }
        }
        return others
    }
    
    
    // Precondition: indices of players that WERE found by currentplayer
    func found(indices: [Int])
    {
        currentPlayer.points += indices.count
        for i in 0..<myPlayers.count
        {
            if(!indices.contains(i) && i != currentPlayerIndex)
            {
                myPlayers[i].points += 1
            }
        }
    }
}
