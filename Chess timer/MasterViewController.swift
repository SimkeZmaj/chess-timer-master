//
//  MasterViewController.swift
//  Chess timer
//
//  Created by Simon Cubalevski on 6/26/19.
//  Copyright © 2019 Simon Cubalevski. All rights reserved.
//

import UIKit
import QuartzCore

class MasterViewController: UIViewController {
    
    @IBOutlet var WhiteSecondLabel : UILabel!
    @IBOutlet var WhiteMinuteLabel : UILabel!
    @IBOutlet var miniWhiteSecondLabel : UILabel!
    @IBOutlet var miniWhiteMinuteLabel : UILabel!
    @IBOutlet var WhiteSecondLabelBlack : UILabel!
    @IBOutlet var WhiteMinuteLabelBlack : UILabel!
    @IBOutlet var miniBlackSecondLabel : UILabel!
    @IBOutlet var miniBlackMinuteLabel : UILabel!
    @IBOutlet var BlackSecondLabel : UILabel!
    @IBOutlet var BlackMinuteLabel : UILabel!
    @IBOutlet var BlackMinuteLabelWhite : UILabel!
    @IBOutlet var BlackSecondLabelWhite : UILabel!
    @IBOutlet var BlackTimeLabelTitle : UILabel!
    @IBOutlet var StartButton : UIButton!
    @IBOutlet var WhiteEndTurnButton : UIButton!
    @IBOutlet var BlackEndTurnButton : UIButton!
    @IBOutlet var BackgroundView: UIView!
    @IBOutlet var BlackLabelColon : UILabel!
    @IBOutlet var WhiteLabelColon : UILabel!
    @IBOutlet var miniBlackLabelColon : UILabel!
    @IBOutlet var miniWhiteLabelColon : UILabel!
    @IBOutlet var whitePauseBtn : UIView!
    @IBOutlet var BlackPauseBtn : UIView!
    
    var timer: Timer?
    var second:Int = 0
    var minute:Int = 0
    var BlackSecond:Int = 0
    var BlackMinute:Int = 0
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTime()
        positionTimer()
        WhiteEndTurnButton.isHidden = true
        BlackEndTurnButton.isHidden = true
        setUpBackground()
    }
    
    // Helper for using hex value with UIColor
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func positionTimer(){
        WhiteMinuteLabelBlack.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        WhiteSecondLabelBlack.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        BlackMinuteLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        BlackSecondLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        miniBlackMinuteLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        miniBlackSecondLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        BlackTimeLabelTitle.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    func setUpBackground() {
        self.miniWhiteMinuteLabel.alpha = 0
        self.miniWhiteSecondLabel.alpha = 0
        self.miniWhiteLabelColon.alpha = 0
        self.BlackSecondLabel.alpha = 0
        self.BlackMinuteLabel.alpha = 0
        self.BlackLabelColon.alpha = 0
        self.BlackPauseBtn.alpha = 0
        print("background set")
    }
    
    func BlackTurnEnd() {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant = 60
            self.view.layoutIfNeeded()
            self.miniBlackMinuteLabel.alpha = 1
            self.miniBlackSecondLabel.alpha = 1
            self.miniBlackLabelColon.alpha = 1
            self.BlackSecondLabel.alpha = 0
            self.BlackMinuteLabel.alpha = 0
            self.BlackLabelColon.alpha = 0
            self.WhiteSecondLabel.alpha = 1
            self.WhiteMinuteLabel.alpha = 1
            self.WhiteLabelColon.alpha = 1
            self.miniWhiteMinuteLabel.alpha = 0
            self.miniWhiteSecondLabel.alpha = 0
            self.miniWhiteLabelColon.alpha = 0
            self.whitePauseBtn.alpha = 1
            self.BlackPauseBtn.alpha = 0
            print("black turn ended")
        })
    }
    
    func WhiteTurnEnd() {
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant = 1000
            self.view.layoutIfNeeded()
            self.miniWhiteMinuteLabel.alpha = 1
            self.miniWhiteSecondLabel.alpha = 1
            self.miniWhiteLabelColon.alpha = 1
            self.BlackSecondLabel.alpha = 1
            self.BlackMinuteLabel.alpha = 1
            self.BlackLabelColon.alpha = 1
            self.WhiteSecondLabel.alpha = 0
            self.WhiteMinuteLabel.alpha = 0
            self.WhiteLabelColon.alpha = 0
            self.miniBlackMinuteLabel.alpha = 0
            self.miniBlackSecondLabel.alpha = 0
            self.miniBlackLabelColon.alpha = 0
            self.whitePauseBtn.alpha = 0
            self.BlackPauseBtn.alpha = 1
        })
    }
    
    @IBAction func startbuttonTapped(sender : AnyObject) {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WhiteCountdown(timer:)) , userInfo: nil, repeats: true)
        StartButton.isHidden = true
        WhiteEndTurnButton.isHidden = false
    }
    
    @IBAction func WhiteEndTurn(sender : AnyObject) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WhiteCountdown(timer:)), userInfo: nil, repeats: true)
        WhiteEndTurnButton.isHidden = true
        BlackEndTurnButton.isHidden = false
        WhiteTurnEnd()
    }
    
    @IBAction func BlackEndTurn(sender : AnyObject) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BlackCountdown(timer:)), userInfo: nil, repeats: true)
        BlackEndTurnButton.isHidden = true
        WhiteEndTurnButton.isHidden = false
        BlackTurnEnd()
    }

    @objc func WhiteCountdown(timer : Timer){
        switch second {
            case 0:
                minute -= 1
                WhiteMinuteLabel.text = String(minute)
                WhiteMinuteLabelBlack.text = String(minute)
                second = 59
                WhiteSecondLabel.text = "59"
                WhiteSecondLabelBlack.text = "59"
                miniWhiteSecondLabel.text = "59"
            case 1...10:
                second -= 1
                WhiteSecondLabel.text = "0" + String(second)
                WhiteSecondLabelBlack.text = "0" + String(second)
                miniWhiteSecondLabel.text = "0" + String(second)
            default:
                second -= 1
                WhiteMinuteLabel.text = String(minute)
                WhiteMinuteLabelBlack.text = String(minute)
                miniWhiteMinuteLabel.text = String(minute)
                WhiteSecondLabel.text = String(second)
                WhiteSecondLabelBlack.text = String(second)
                miniWhiteSecondLabel.text = String(second)
            
        }
        if minute == 0 && second == 0 {
           self.timer?.invalidate()
            print("White Countdown hits 0")
            // add some kind of end game trigger here
        }
        
    }
    
    @objc func BlackCountdown(timer : Timer){
        switch BlackSecond {
        case 0:
            BlackMinute -= 1
            BlackMinuteLabel.text = String(BlackMinute)
            BlackMinuteLabelWhite.text = String(BlackMinute)
            BlackSecond = 59
            BlackSecondLabel.text = "59"
            BlackSecondLabelWhite.text = "59"
            miniBlackSecondLabel.text = "59"
        case 1...10:
            BlackSecond -= 1
            BlackSecondLabel.text = "0" + String(BlackSecond)
            BlackSecondLabelWhite.text = "0" + String(BlackSecond)
            miniBlackSecondLabel.text = "0" + String(BlackSecond)
        default:
            BlackSecond -= 1
            BlackMinuteLabel.text = String(BlackMinute)
            BlackMinuteLabelWhite.text = String(BlackMinute)
            miniBlackMinuteLabel.text = String(BlackMinute)
            BlackSecondLabel.text = String(BlackSecond)
            BlackSecondLabelWhite.text = String(BlackSecond)
            miniBlackSecondLabel.text = String(BlackSecond)
            
        }
        if BlackMinute == 0 && BlackSecond == 0 {
            self.timer?.invalidate()
            print("Black Countdown hits 0")
            // add some kind of end game trigger here
        }
        
    }
    
    func resetTime(){
        minute = 10
        second = 0
        BlackMinute = 10
        BlackSecond = 0
        if second == 0 {
            WhiteSecondLabel.text = "00"
            WhiteSecondLabelBlack.text = "00"
            miniWhiteSecondLabel.text = "00"
            BlackSecondLabel.text = "00"
            BlackSecondLabelWhite.text = "00"
            miniBlackSecondLabel.text = "00"
        } else {
            WhiteSecondLabel.text = String(second)
            WhiteSecondLabelBlack.text = String(second)
            miniWhiteSecondLabel.text = String(second)
            BlackSecondLabel.text = String(second)
            BlackSecondLabelWhite.text = String(second)
            miniBlackSecondLabel.text = String(second)
        }
        WhiteMinuteLabel.text = String(minute)
        WhiteMinuteLabelBlack.text = String(minute)
        miniWhiteMinuteLabel.text = String(minute)
        BlackMinuteLabel.text = String(minute)
        BlackMinuteLabelWhite.text = String(minute)
        miniBlackMinuteLabel.text = String(minute)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide the status bar
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }
    

    @IBAction func showActionSheet(sender: AnyObject) {
        self.timer?.invalidate()
        let optionMenu = UIAlertController(title: nil, message: "Game Paused", preferredStyle: .actionSheet)
        let reset30 = UIAlertAction(title: "New 30 Minutes Game", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.StartButton.isHidden = false
            
            self.BlackTurnEnd()
            self.minute = 30
            self.second = 0
            self.BlackMinute = 30
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)
        })
        let reset20 = UIAlertAction(title: "New 20 Minutes Game", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.StartButton.isHidden = false
            
            self.BlackTurnEnd()
            self.minute = 20
            self.second = 0
            self.BlackMinute = 20
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)
        })
        let reset15 = UIAlertAction(title: "New 15 Minutes Game", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.StartButton.isHidden = false
            
            self.BlackTurnEnd()
            self.minute = 15
            self.second = 0
            self.BlackMinute = 15
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)
        })

        let reset10 = UIAlertAction(title: "New 10 Minutes Game", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.StartButton.isHidden = false
            
            self.BlackTurnEnd()
            self.minute = 10
            self.second = 0
            self.BlackMinute = 10
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)
        })
        let reset7 = UIAlertAction(title: "New 7 Minutes Game", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.StartButton.isHidden = false
            
            self.BlackTurnEnd()
            self.minute = 7
            self.second = 0
            self.BlackMinute = 7
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)
        })

        let reset5 = UIAlertAction(title: "New 5 Minutes Game", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
  
            self.StartButton.isHidden = false
            
            self.BlackTurnEnd()
            self.minute = 5
            self.second = 0
            self.BlackMinute = 5
            self.BlackSecond = 0
            if self.second == 0 {
                self.WhiteSecondLabel.text = "00"
                self.WhiteSecondLabelBlack.text = "00"
                self.miniWhiteSecondLabel.text = "00"
                self.BlackSecondLabel.text = "00"
                self.BlackSecondLabelWhite.text = "00"
                self.miniBlackSecondLabel.text = "00"
            } else {
                self.WhiteSecondLabel.text = String(self.second)
                self.WhiteSecondLabelBlack.text = String(self.second)
                self.miniWhiteSecondLabel.self.text = String(self.second)
                self.BlackSecondLabel.text = String(self.second)
                self.BlackSecondLabelWhite.text = String(self.second)
                self.miniBlackSecondLabel.text = String(self.second)
            }
            self.WhiteMinuteLabel.text = String(self.minute)
            self.WhiteMinuteLabelBlack.text = String(self.minute)
            self.miniWhiteMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabel.text = String(self.minute)
            self.BlackMinuteLabelWhite.text = String(self.minute)
            self.miniBlackMinuteLabel.text = String(self.minute)

            print("5 min game restarted")
        })
        
        let cancelAction = UIAlertAction(title: "Resume", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Game Resumed")
            if self.WhiteEndTurnButton.isHidden {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.BlackCountdown(timer:)), userInfo: nil, repeats: true)
            } else {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.WhiteCountdown(timer:)), userInfo: nil, repeats: true)
            }
                   })
        
        optionMenu.addAction(reset30)
        optionMenu.addAction(reset20)
        optionMenu.addAction(reset15)
        optionMenu.addAction(reset10)
        optionMenu.addAction(reset7)
        optionMenu.addAction(reset5)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }


}

