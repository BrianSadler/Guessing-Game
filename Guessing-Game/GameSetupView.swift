//
//  GameSetupView.swift
//  Guessing-Game
//
//  Created by Brian Sadler on 9/26/18.
//  Copyright © 2018 Brian Sadler. All rights reserved.
//

import UIKit
import AVFoundation

class GameSetupView: UIViewController {
    @IBOutlet weak var UpDown: UIStepper!
    @IBOutlet weak var MaxNum: UILabel!
    @IBOutlet weak var GuessChoiceOutlet: UISegmentedControl!
    @IBOutlet weak var PlayOutlet: UIButton!
    @IBOutlet weak var Welcome: UILabel!
    @IBOutlet weak var Rules: UILabel!
    var colorArray:[UIColor] = [UIColor.yellow,  UIColor.purple,UIColor.red, UIColor.lightGray, UIColor.cyan]
    var colorArray2:[UIColor] = [UIColor.green, UIColor.orange, UIColor.blue, UIColor.black]
    var numOfAttempts = 5
    var randomNumber = 100
    @IBOutlet weak var Background: UIImageView!
    var music: AVAudioPlayer!
    func playMusic() {
        if let musicURL = Bundle.main.url(forResource: "Noice", withExtension: "mp3") {
            if let audioPlayer = try? AVAudioPlayer(contentsOf: musicURL) {
                music = audioPlayer
                music.numberOfLoops = -1
                music.play()
                
                
            }
        }
    }
    
    @objc func discoBackground() {
        let randomColor = colorArray[Int(arc4random_uniform(UInt32(colorArray.count)))]
        let randomColor2 = colorArray2[Int(arc4random_uniform(UInt32(colorArray2.count)))]
        self.view.backgroundColor = randomColor
        Welcome.textColor = randomColor2
        Welcome.backgroundColor = randomColor
        Rules.textColor = randomColor2
        Rules.backgroundColor = randomColor
        GuessChoiceOutlet.tintColor = randomColor2
        
        
        }
 
  
    
 
    @IBAction func PlayGG(_ sender: UIButton) {
        performSegue(withIdentifier: "mySegue", sender: self)
    }
    @IBAction func AttemptChoice(_ sender: Any) {
        switch  GuessChoiceOutlet.selectedSegmentIndex {
        case 0:
            numOfAttempts = 5
            Rules.text = "There are \(numOfAttempts) attempts to guess a random # 1-100"
        case 1:
            numOfAttempts = 25
              Rules.text = "There are \(numOfAttempts) attempts to guess a random # 1-100"
        case 2:
            numOfAttempts = 50
              Rules.text = "There are \(numOfAttempts) attempts to guess a random # 1-\(Int(UpDown.value))"
        case 3:
            numOfAttempts = 100
              Rules.text = "There are \(numOfAttempts) attempts to guess a random # 1-\(Int(UpDown.value))"
            default:
            numOfAttempts = 5
              Rules.text = "There are \(numOfAttempts) attempts to guess a random # 1-\(Int(UpDown.value))"
        }
    }
    @IBAction func UpDownPress(_ sender: Any) {
        MaxNum.text = "\(Int(UpDown.value))"
        Rules.text = "There are \(numOfAttempts) attempts to guess a random # 1-\(Int(UpDown.value))"
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var UBNum = Int(MaxNum.text!)
        
        if let viewController = segue.destination as? ViewController {
            
            UBNum = Int(MaxNum.text!)
            
            
            guard UBNum != nil else { return viewController.randomNumber = Int(arc4random_uniform(100)) + 1 }
            
            viewController.randomNumber = Int.random(in: 0..<UBNum!)
            
            if UBNum == 0 {
                
                viewController.randomNumber = Int(arc4random_uniform(100)) + 1
                
            }
            
            viewController.numOfAttempts = numOfAttempts
            if let UBNum = Int(MaxNum.text!) {
                randomNumber = Int.random(in: 0..<UBNum)
                viewController.randomNumber = randomNumber
            } else {
                randomNumber = Int(arc4random_uniform(100)) + 1
            }
        
        }
    }
    
    

    
    
    
  
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(discoBackground), userInfo: nil, repeats: true)
        playMusic()
        let gifBackground = UIImage.gifImageWithName("DanceBackground")
        Background.image = gifBackground
        discoBackground()
       

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

