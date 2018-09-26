//
//  ViewController.swift
//  Guessing-Game
//
//  Created by Brian Sadler on 9/21/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var colorArray:[UIColor] = [UIColor.yellow, UIColor.green, UIColor.orange, UIColor.purple, UIColor.blue, UIColor.magenta, UIColor.red]
    var userChoice = 0
    var numOfAttempts = 5
    var numOfWins = 0
    var numOfLoses = 0
    var randomNumber = Int(arc4random_uniform(100)) + 1
    var newGame = false
    
    func gameState() {
        if numOfAttempts > 0 {
            reset.isHidden = true
    
        }
        else if numOfAttempts == 0 {
            reset.isHidden = false
            Submit.isHidden = true
            GuessStatus.text = "Nice try the number was \(randomNumber)"
            numOfLoses += 1
            LossLabel.text = "Losses:\(numOfLoses)"
           
        }
        }
    @objc func winnerBackground() {
        if newGame == false {
        let randomColor = colorArray[Int(arc4random_uniform(UInt32(colorArray.count)))]
        self.view.backgroundColor = randomColor
        }
    }



    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var WinLabel: UILabel!
    @IBOutlet weak var LossLabel: UILabel!
    func attemptWarning() {
        if numOfAttempts == 5 || numOfAttempts == 4 {
            self.view.backgroundColor = UIColor.green
        }
        else if numOfAttempts == 3 {
            self.view.backgroundColor = UIColor.yellow
        }
        else if numOfAttempts <= 2 {
            self.view.backgroundColor = UIColor.red
        }
    }
    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var UserInput: UITextField!
    @IBAction func SubmitGuess(_ sender: Any) {
        attemptWarning()
        gameState()
      let guess = Int(UserInput.text!)!
        if guess == randomNumber {
            GuessStatus.text = "Congrats! You won!"
            numOfWins += 1
            WinLabel.text = "Wins:\(numOfWins)"
            Submit.isHidden = true
          Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(winnerBackground), userInfo: nil, repeats: true)
            reset.isHidden = false
        }
        else if guess > randomNumber {
            GuessStatus.text = "Try a lower number"
            numOfAttempts -= 1
              AttemptsLeft.text = "Remaining Attempts: \(numOfAttempts)"
            gameState()
        }
        else  {
            GuessStatus.text = "Try a higher number"
            numOfAttempts -= 1
            AttemptsLeft.text = "Remaining Attempts: \(numOfAttempts)"
            gameState()
        }
        
        
            
        }
    @IBOutlet weak var GuessStatus: UILabel!
    @IBOutlet weak var AttemptsLeft: UILabel!
    @IBAction func ResetGame(_ sender: Any) {
        newGame = true
        if newGame == true {
            randomNumber = Int(arc4random_uniform(100)) + 1
            numOfAttempts = 5
             AttemptsLeft.text = "Remaining Attempts: \(numOfAttempts)"
            Submit.isHidden = false
            attemptWarning()
            GuessStatus.text = "New game started"
            gameState()
            
            
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
 
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     attemptWarning()
        gameState()
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
             view.addGestureRecognizer(tap)
        
        
    }


}

