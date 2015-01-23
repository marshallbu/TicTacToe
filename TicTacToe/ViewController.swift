//
//  ViewController.swift
//  TicTacToe
//
//  Created by Marshall Upshur on 1/13/15.
//  Copyright (c) 2015 Marshall Upshur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var goNumber = 1
    
    //    var board =
    // 0 = empty, 1 = nought, 2 = cross
    //    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winner = 0
    var gameState = [Int](count: 9, repeatedValue: 0)
    let winningCombos = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [2,4,6],
        [0,4,8]
    ]
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var playAgain: UIButton!
    @IBAction func playAgainPressed(sender: AnyObject) {
        goNumber = 1
        winner = 0
        gameState = [Int](count: 9, repeatedValue: 0)
        winnerLabel.hidden = true
        winnerLabel.center = CGPointMake(winnerLabel.center.x - 400, winnerLabel.center.y)
        playAgain.alpha = 0
        
        var button: UIButton
        for var i = 0; i < 9; i++ {
//            println(view.viewWithTag(i))
            button = view.viewWithTag(i) as UIButton
            button.setImage(nil, forState: .Normal)
        }
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        
        if (gameState[sender.tag] == 0 && winner == 0) {
            var image = UIImage()
            
            if (goNumber%2 == 0) {
                gameState[sender.tag] = 2
                image = UIImage(named: "cross.png")!
            } else {
                gameState[sender.tag] = 1
                image = UIImage(named: "nought.png")!
            }
            
            goNumber++
            sender.setImage(image, forState: .Normal)
            
            winner = checkForWin()
            if (winner != 0) {
                winnerLabel.hidden = false
                winnerLabel.text = "Player \(winner) won!"
                
                UIView.animateWithDuration(0.3, animations: {
                    self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x + 400, self.winnerLabel.center.y)
                })
                
                UIView.animateWithDuration(0.3, animations: {
                    self.playAgain.alpha = 1
                })
            }
        }
        
    }
    
    func checkForWin() -> Int {
        var winner = 0
        for combo in winningCombos {
            if (gameState[combo[0]] == gameState[combo[1]] &&
                gameState[combo[1]] == gameState[combo[2]] &&
                gameState[combo[0]] != 0) {
                winner = gameState[combo[0]]
            }
        }
        
        return winner
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        winnerLabel.hidden = true
        winnerLabel.center = CGPointMake(winnerLabel.center.x - 400, winnerLabel.center.y)
        
        playAgain.alpha = 0
    }


}

