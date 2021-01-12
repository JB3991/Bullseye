//
//  ViewController.swift
//  Bullseye
//
//  Created by Jonathan Burnett on 12/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    var currentValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var round = 0
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage(named: "SliderThumb-Hightlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackImageLeft = #imageLiteral(resourceName: "SliderTrackLeft") //UIImage(named: "SliderTrackedLeft")
        let trackleftResizable = trackImageLeft.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackleftResizable, for: .normal)
        
        let trackImageRight = #imageLiteral(resourceName: "SliderTrackRight") // UIImage(named: "SliderTrackedRight")
        let trackRightResizable = trackImageRight.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)

        }
    
    // Reset Score and Round
    @IBAction func startNewGame () {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String (score)
        roundLabel.text = String(round)
    }
    
    // Updating the the round and Target Value every time the user enters a new round
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        // reset slider to middle (50)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
        round += 1
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("the value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }

    @IBAction func showAlert() {
        
        // converting the score to a postive
        let difference = abs (targetValue - currentValue)
        
        var points = 0
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            points += 50
        }else if difference < 10 {
            title = "Pretty good!"
            points += 10
        }else {
            title = "You suck!"
            points += 0
        }
        
        score += points
    
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


