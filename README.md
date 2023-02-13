# 프로젝트 설명
+ 최소한의 휴식시간으로 최대한의 근성장을 불러일으키기 위한 앱으로 소근육(어깨, 팔, 복부, 종아리 등)은 10초라는 최소한의 휴식시간으로 설정하고, 대근육(가슴, 등, 하체 등)은 30초의 휴식시간을 가질 수 있는 앱입니다.
---

# 전체 소스 & 해석
+ ViewController.swift

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerButton: UIButton!
    @IBOutlet var segment: UISegmentedControl!
    
    var secondsLeft: Int = 10   // 10초로 설정
    var timer: Timer?
    
    override func viewDidLoad() {
        timerButton.layer.cornerRadius = 15  // 버튼 코너 라운드 15로 설정
        timerButton.layer.borderWidth = 5   // 버튼 두께 5로 설정
        
        self.updateTimeLeft()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 리셋 함수 
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        timerButton.setTitle("쉬는 시간", for: .normal)
        
    }
    
    func updateTimerLabel() {
        let minutes = self.secondsLeft / 60     // 남은 분
        let seconds = self.secondsLeft % 60     // 남은 초
        
        if self.secondsLeft < 10 {
            self.timerLabel.textColor = UIColor.red       // 10초 이하 시 텍스트 컬러 빨간색 
        } else {
            self.timerLabel.textColor = UIColor.black    // 10초 이상 시 텍스트 컬러 검은색  
        }
        
        UIView.transition(with: self.timerLabel, duration: 0.3, options: .transitionFlipFromBottom) {
            if self.secondsLeft > 0 {   // 남은 초가 0보다 클 경우 
                self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds) // 분이랑 초가 나오게 설정 
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
    
    //타이머 함수 다시 쓰기
    @IBAction func timerButtonClicked(_ sender: UIButton) {
        if timer != nil { 
            resetTimer()
            return
            
        }
        
        self.timerButton.setTitle("웨이트 시작!!", for: .normal)
        self.updateTimeLeft()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
            self.secondsLeft -= 1    // 남은 초에서 1초 빼기 
            self.updateTimerLabel()
            
            if self.secondsLeft == 0 { // 0초가 되면 타이머 리셋
                self.resetTimer()
            }
        }
        
    }
    
}
```
---

# 스크린샷
![image](https://user-images.githubusercontent.com/106370789/174237395-851e28ce-2826-4573-b84b-11929020c0a7.png)

![image](https://user-images.githubusercontent.com/106370789/174237422-25b02009-0cf8-4be7-a6f2-77e54ec8d6d4.png)

![image](https://user-images.githubusercontent.com/106370789/174237452-be22b0f4-ca6c-4260-992c-46492a7b82b6.png)





