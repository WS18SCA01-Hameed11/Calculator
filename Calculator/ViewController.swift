//
//  ViewController.swift
//  Calculator
//
//  Created by Hameed Abdullah on 12/21/18.
//  Copyright © 2018 Hameed Abdullah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var sound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.text = "0"
        
        if let path = Bundle.main.path(forResource: "btn", ofType: "wav") {
            let soundURL = URL(fileURLWithPath: path)
            
            do {
                try sound = AVAudioPlayer(contentsOf: soundURL)
                sound.prepareToPlay()
            } catch  {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    func playSound() {
        if sound.isPlaying {
            sound.stop()
        }
        sound.play()
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        label.text = "0"
    }
    
    @IBAction func digitPressed(_ sender: UIButton) {
        playSound()
        //button has titleLabel property
        if let titleLabel: UILabel = sender.titleLabel {
            if let digit: String = titleLabel.text {
                if label.text == "0" {
                    label.text = ""
                }

                //append digit value from the button that has been pressded to  label.text!
                label.text! += digit
            }
        }
        

    }
    
    @IBAction func decimalPointedPressed(_ sender: UIButton) {
        if label.text == "0" {
            label.text = ""
        }
        label.text! += "."
    }
    
    @IBAction func operatorKeyPressed(_ sender: UIButton) {
        
        if let titleLabel: UILabel = sender.titleLabel {
            if let myOperator: String = titleLabel.text {
                label.text! += myOperator
            }
        }
        
    }
    
    @IBAction func equalKeyPressed(_ sender: UIButton) {
        
        var s: String = label.text!
        s = s.replacingOccurrences(of: "−", with: "-")
        s = s.replacingOccurrences(of: "×", with: "*")
        //avoid Int division
        s = s.replacingOccurrences(of: "÷", with: ".0/")
        
        //Not attempting to detect syntax errors; would require Objective-C.
        let expression: NSExpression = NSExpression(format: s)
        if let result: NSNumber = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            
            label.text = result.stringValue
            
//            //can set label.text = even if label.text is nil
//            //but cant say label.text += if label.text might be nil
//            if let text: String = label.text {
//                label.text = text + "\n" + result.stringValue
//            } else {
//                label.text = result.stringValue
//            }
            
        }
    }
    
    
    
}
























