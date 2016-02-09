//
//  ViewController.swift
//  calculator
//
//  Created by Andrew Ingram on 2016-02-04.
//  Copyright © 2016 Sabring. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel:UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
                buttonSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
    }
    
    @IBAction func numberPressed(button: UIButton!){
        playSound()
        
        runningNumber += "\(button.tag)"
        outputLabel.text = runningNumber
    }

    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
        
    }

    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubstractPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPress(sender: AnyObject) {
        playSound()
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        outputLabel.text = "0"
        
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
            
                rightValStr = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    result = ("\(Double(leftValStr)! * Double(rightValStr)!)")
                
                } else if currentOperation == Operation.Divide {
                    result = ("\(Double(leftValStr)! / Double(rightValStr)!)")
                
                } else if currentOperation == Operation.Subtract {
                    result = ("\(Double(leftValStr)! - Double(rightValStr)!)")
                
                } else if currentOperation == Operation.Add {
                    result = ("\(Double(leftValStr)! + Double(rightValStr)!)")
                
                }
                leftValStr = result
                outputLabel.text = result
            }
            
                currentOperation = op
            
            }else{
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
            
        }
        buttonSound.play()
    }
    
}

