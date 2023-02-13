//
//  ViewController.swift
//  헬스 타이머
//
//  Created by 203a21 on 2022/06/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerButton: UIButton!
    @IBOutlet var segment: UISegmentedControl!
    
    var secondsLeft: Int = 10
    var timer: Timer?
    
    override func viewDidLoad() {
        timerButton.layer.cornerRadius = 15
        timerButton.layer.borderWidth = 5
        
        self.updateTimeLeft()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        timerButton.setTitle("쉬는 시간", for: .normal)
        
    }
    
    func updateTimerLabel() {
        let minutes = self.secondsLeft / 60
        let seconds = self.secondsLeft % 60
        
        if self.secondsLeft < 10 {
            self.timerLabel.textColor = UIColor.red
        } else {
            self.timerLabel.textColor = UIColor.black
        }
        
        UIView.transition(with: self.timerLabel, duration: 0.3, options: .transitionFlipFromBottom) {
            if self.secondsLeft > 0 {
                self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            } else {
                self.timerLabel.text = "시작!!"
            }
        } completion: { (animated) in
            
        }
    }
    
    func updateTimeLeft() {
        self.secondsLeft = 10 + segment.selectedSegmentIndex * 20
        self.updateTimerLabel()
    }

    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        self.resetTimer()
        self.updateTimeLeft()
    }
    @IBAction func timerButtonClicked(_ sender: UIButton) {
        if timer != nil {
            resetTimer()
            return
        }
        
        self.timerButton.setTitle("웨이트 시작!!", for: .normal)
        self.updateTimeLeft()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
            self.secondsLeft -= 1
            self.updateTimerLabel()
            
            if self.secondsLeft == 0 {
                self.resetTimer()
            }
        }
        
    }
    
}

