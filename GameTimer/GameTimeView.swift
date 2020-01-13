//
//  GameTime.swift
//  basket-manager
//
//  Created by Nobuhiro Harada on 2019/04/07.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

enum TextColorState: String {
    case red, green, yellow, white, systemBlue, systemIndigo, systemOrange, systemPink, systemTeal
}

final class GameTimeView: UIView {
    
    // 試合時間ラベル
    var gameTimer: Timer!
    var gameSeconds = 600
    var oldGameSeconds = 600
    var gameTimerStatus: GameTimerStatus = .START
    enum GameTimerStatus: String {
        case START
        case STOP
        case RESUME
    }
    
    var gameMinLabel: GameTimeLabel
    var gameSecLabel: GameTimeLabel
    var gameColonLabel: GameTimeLabel
    var gameControlButton: ControlButton
    var gameResetButton: ResetButton
    var buzzerButton: BuzzerButton
    var autoBuzzerLabel: AutoBuzzerLabel
    var settingButton: SettingButton
    
    // 試合時間ピッカー
    var minArray: [String] = []
    var secArray: [String] = []
    var picker: UIPickerView
    var pickerMinLabel: UILabel
    var pickerSecLabel: UILabel
    
    override init(frame: CGRect) {
        
        // GameTime ラベル
        gameMinLabel = GameTimeLabel()
        gameMinLabel.text = "10"
        
        gameColonLabel = GameTimeLabel()
        gameColonLabel.text = ":"
        
        gameSecLabel = GameTimeLabel()
        gameSecLabel.text = "00"
        
        gameSeconds = Int(gameMinLabel.text!)!*60
        gameSeconds += Int(gameSecLabel.text!)!
        
        // GameTime ピッカー
        for i in 0...60 { //分設定(ゲームタイムピッカー用)
            minArray.append(String(format: "%02d", i))
        }
        
        for i in 0..<60 { //秒設定(ゲームタイムピッカー用)
            secArray.append(String(format: "%02d", i))
        }
        
        picker = UIPickerView(frame: CGRect.zero)
        
        picker.setValue(UIColor.white, forKey: "textColor")

        pickerMinLabel = UILabel()
        pickerMinLabel.text = "picker_min".localized
        pickerMinLabel.font = UIFont(name: "Avenir Next", size: 20)
        pickerMinLabel.textColor = gameMinLabel.getTextColor()
        pickerMinLabel.sizeToFit()

        picker.addSubview(pickerMinLabel)

        pickerSecLabel = UILabel()
        pickerSecLabel.text = "picker_sec".localized
        pickerSecLabel.font = UIFont(name: "Avenir Next", size: 20)
        pickerSecLabel.textColor = gameMinLabel.getTextColor()
        pickerSecLabel.sizeToFit()

        picker.addSubview(pickerSecLabel)

        // 試合時間 ボタン
        gameControlButton = ControlButton()
        gameResetButton = ResetButton()
        gameResetButton.isEnabled = false
        buzzerButton = BuzzerButton()
        autoBuzzerLabel = AutoBuzzerLabel()
        settingButton = SettingButton()
        
        super.init(frame: frame)
        
        picker.delegate = self
        picker.dataSource = self
        
        picker.selectRow(10, inComponent: 0, animated: true)
        picker.selectRow(0, inComponent: 1, animated: true)
        
        toggleGameLabels()
        
        self.addSubview(gameMinLabel)
        self.addSubview(gameColonLabel)
        self.addSubview(gameSecLabel)
        self.addSubview(gameControlButton)
        self.addSubview(gameResetButton)
        self.addSubview(buzzerButton)
        self.addSubview(autoBuzzerLabel)
        self.addSubview(settingButton)
        self.addSubview(picker)
        
        addButtonAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkCurrentDevice() {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            checkOrientation4Pad()
            
        case .phone:
            checkOrientation4Phone()

        default:
            break
        }
    }
    
    func checkOrientation4Phone() {
        if isLandscape {
            setParams4PhoneLandscape()
        } else {
            setParams4PhonePortrait()
        }
    }
    
    func checkOrientation4Pad() {
        if isLandscape {
            setParams4PadLandscape()
        } else {
            setParams4PadPortrait()
        }
    }
    
    func portrait(frame: CGRect) {
        
        self.frame = frame
        checkCurrentDevice()
        
        let gameLabelY = frame.height/2
        
        gameMinLabel.center = CGPoint(x: frame.width*(1/3)-30,
                                      y: gameLabelY)
        
        gameColonLabel.center = CGPoint(x: frame.width*(1/2),
                                        y: gameLabelY)
        
        gameSecLabel.center = CGPoint(x: frame.width*(2/3)+30,
                                      y: gameLabelY)
        
        let buttonY = frame.height*(3/4)
        
        gameControlButton.center = CGPoint(x: frame.width*(1/4), y: buttonY)
        
        gameResetButton.center = CGPoint(x: frame.width*(2/4), y: buttonY)
        
        buzzerButton.center = CGPoint(x: frame.width*(3/4), y: buttonY)
        autoBuzzerLabel.center = CGPoint(x: frame.width*(3/4), y: buttonY-36)
        
        settingButton.center = CGPoint(x: frame.width*(1/12), y: frame.height*(1/12))
        
        pickerMinLabel.frame = CGRect(x: picker.bounds.width*0.4 - pickerMinLabel.bounds.width/2,
                                              y: picker.bounds.height/2 - (pickerMinLabel.bounds.height/2),
                                              width: pickerMinLabel.bounds.width,
                                              height: pickerMinLabel.bounds.height)
        
        pickerSecLabel.frame = CGRect(x: picker.bounds.width*0.9 - pickerSecLabel.bounds.width/2,
                                              y: picker.bounds.height/2 - (pickerSecLabel.bounds.height/2),
                                              width: pickerSecLabel.bounds.width,
                                              height: pickerSecLabel.bounds.height)

    }
    
    func landscape(frame: CGRect) {
        
        self.frame = frame
        checkCurrentDevice()
        
        let gameLabelY = frame.height*(1/2)
        
        gameMinLabel.center = CGPoint(x: frame.width*(1/4),
                                      y: gameLabelY)
        
        gameColonLabel.center = CGPoint(x: frame.width*(1/2),
                                        y: gameLabelY)
        
        gameSecLabel.center = CGPoint(x: frame.width*(3/4),
                                      y: gameLabelY)
        
        pickerMinLabel.frame = CGRect(x: 0, y: 0, width: pickerMinLabel.bounds.width, height: pickerMinLabel.bounds.height)
        pickerMinLabel.center = CGPoint(x: frame.width*3/8, y: picker.frame.height/2)
        
        pickerSecLabel.frame = CGRect(x: 0, y: 0, width: pickerSecLabel.bounds.width, height: pickerSecLabel.bounds.height)
        pickerSecLabel.center = CGPoint(x: frame.width*7/8, y: picker.frame.height/2)
        
        let gameTimeButtonY = frame.height*(7/8)
        
        gameControlButton.center = CGPoint(x: frame.width*(2/8), y: gameTimeButtonY)
        
        gameResetButton.center = CGPoint(x: frame.width*(4/8), y: gameTimeButtonY)
        
        buzzerButton.center = CGPoint(x: frame.width*(6/8), y: gameTimeButtonY)
        autoBuzzerLabel.center = CGPoint(x: frame.width*(6/8), y: gameTimeButtonY-36)
        
        settingButton.center = CGPoint(x: frame.width*(1/12), y: frame.height*(1/12))
    }
    
    
    func setParams4PhonePortrait() {

        gameMinLabel.setParams4PhonePortrait()
        
        gameColonLabel.bounds = CGRect(x: 0, y: 0, width: 30, height: 140)
        gameColonLabel.font = UIFont(name: "DigitalDismay", size: 100)
        
        gameSecLabel.setParams4PhonePortrait()

        picker.frame = CGRect(x: 0, y: 0, width: frame.width, height: 200)
        picker.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    func setParams4PhoneLandscape() {
        
        gameMinLabel.setParams4PhoneLandscape()
        
        gameColonLabel.bounds = CGRect(x: 0, y: 0, width: 50, height: 210)
        gameColonLabel.font = UIFont(name: "DigitalDismay", size: 150)
        
        gameSecLabel.setParams4PhoneLandscape()
        
        picker.frame = CGRect(x: 0, y: 0, width: frame.width, height: 200)
        picker.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    func setParams4PadPortrait() {
        gameMinLabel.setParams4PadPortrait()
        
        gameColonLabel.bounds = CGRect(x: 0, y: 0, width: 60, height: 200)
        gameColonLabel.font = UIFont(name: "DigitalDismay", size: 200)
        
        gameSecLabel.setParams4PadPortrait()
        
        picker.frame = CGRect(x: 0, y: 0, width: frame.width, height: 400)
        picker.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    func setParams4PadLandscape() {
        gameMinLabel.setParams4PadLandscape()
        
        gameColonLabel.bounds = CGRect(x: 0, y: 0, width: 90, height: 240)
        gameColonLabel.font = UIFont(name: "DigitalDismay", size: 300)
        
        gameSecLabel.setParams4PadLandscape()
        
        picker.frame = CGRect(x: 0, y: 0, width: frame.width, height: 500)
        picker.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    func toggleGameLabels() {
        gameMinLabel.isHidden.toggle()
        gameColonLabel.isHidden.toggle()
        gameSecLabel.isHidden.toggle()
    }
    
    func addButtonAction() {
        
        self.gameControlButton.addTarget(self, action: #selector(GameTimeView.gameControlButton_tapped), for: .touchUpInside)
        
        self.gameResetButton.addTarget(self, action: #selector(GameTimeView.gameResetButton_tapped), for: .touchUpInside)
        
        self.buzzerButton.addTarget(self, action: #selector(GameTimeView.buzzerButton_touchDown), for: .touchDown)
        
        self.buzzerButton.addTarget(self, action: #selector(GameTimeView.buzzerButton_touchUp), for: [.touchUpInside, .touchUpOutside])
        
        self.settingButton.addTarget(self, action: #selector(GameTimeView.settingButton_touchUp), for: [.touchUpInside, .touchUpOutside])
        
    }
    
    @objc func gameControlButton_tapped(_ sender: UIButton) {
        
        switch self.gameTimerStatus {
        case .START:
            self.runGameTimer()
            self.gameControlButton.setImage(UIImage(named: "stop.png"), for: .normal)
            self.gameTimerStatus = .STOP
            self.toggleGameLabels()
            self.picker.isHidden = !self.picker.isHidden
            self.gameResetButton.isEnabled = true
            
        case .STOP:
            self.gameTimer.invalidate()
            self.gameControlButton.setImage(UIImage(named: "start.png"), for: .normal)
            self.gameTimerStatus = .RESUME
            
        case .RESUME:
            self.runGameTimer()
            self.gameControlButton.setImage(UIImage(named: "stop.png"), for: .normal)
            self.gameTimerStatus = .STOP
        }
    }
    
    @objc func gameResetButton_tapped(_ sender: UIButton) {
        
        self.gameTimer.invalidate()
        self.gameSeconds = self.oldGameSeconds
        self.showGameTime()
        self.gameControlButton.setImage(UIImage(named: "start.png"), for: .normal)
        self.gameTimerStatus = .START
        self.toggleGameLabels()
        self.picker.isHidden = !self.picker.isHidden
        self.gameResetButton.isEnabled = false
    }
    
    @objc func buzzerButton_touchDown(_ sender: UIButton) {
        mainViewController.buzzerPlayer?.play()
        self.buzzerButton.setImage(UIImage(named: "buzzer-down"), for: .normal)
    }
    
    @objc func buzzerButton_touchUp(_ sender: UIButton) {
        mainViewController.buzzerPlayer?.stop()
        mainViewController.buzzerPlayer?.currentTime = 0
        self.buzzerButton.setImage(UIImage(named: "buzzer-up"), for: .normal)
    }
    
    @objc func settingButton_touchUp(_ sender: UIButton) {
        
        let settingViewController = SettingViewController()
        settingViewController.gameTimeView = self
        
        let navigationController = UINavigationController(rootViewController: settingViewController)
        let currentViewController = self.topViewController()
        currentViewController?.present(navigationController, animated: true, completion: nil)
    }
    
    func runGameTimer(){
        self.gameTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.gameTimerCount),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func gameTimerCount() {
        if self.gameSeconds < 1 {
            
            if (userdefaults.bool(forKey: BUZEER_AUTO_BEEP)) {
                mainViewController.buzzerPlayer?.play()
                self.buzzerButton.setImage(UIImage(named: "buzzer-down"), for: .normal)
            }
            
            self.gameTimer.invalidate()
            self.gameSecLabel.text = "00"
            self.openGameTimeOverDialog()
        } else {
            self.gameSeconds -= 1
            self.showGameTime()
        }
    }
    
    func showGameTime() {
        let min = self.gameSeconds/60
        let sec = self.gameSeconds%60
        self.gameMinLabel.text = String(format: "%02d", min)
        self.gameSecLabel.text = String(format: "%02d", sec)
    }
    
    func openGameTimeOverDialog() {
        AlertDialog.showTimeover(title: "shotclock_over".localized, viewController: mainViewController) {
            self.gameTimer.invalidate()
            self.gameSeconds = self.oldGameSeconds
            self.showGameTime()
            self.gameControlButton.setImage(UIImage(named: "start.png"), for: .normal)
            self.gameTimerStatus = .START
            self.gameResetButton.isEnabled = false
            self.toggleGameLabels()
            self.picker.isHidden = !self.picker.isHidden
        }
    }
    
    func reset() {
        if gameTimer != nil {
           gameTimer.invalidate()
        }
        gameSeconds = 600
        oldGameSeconds = 600
        let min = gameSeconds/60
        let sec = gameSeconds%60
        gameMinLabel.text = String(format: "%02d", min)
        gameSecLabel.text = String(format: "%02d", sec)
        gameControlButton.setImage(UIImage(named: "start.png"), for: .normal)
        gameResetButton.isEnabled = false
        gameTimerStatus = .START
        gameMinLabel.isHidden = true
        gameColonLabel.isHidden = true
        gameSecLabel.isHidden = true
        
        picker.isHidden = false
        picker.selectRow(10, inComponent: 0, animated: true)
        picker.selectRow(0, inComponent: 1, animated: true)
        
        gameMinLabel.textColor = .yellow
        gameColonLabel.textColor = .yellow
        gameSecLabel.textColor = .yellow
        pickerMinLabel.textColor = .yellow
        pickerSecLabel.textColor = .yellow
        picker.reloadAllComponents()
        userdefaults.setState(.yellow, forKey: GAME_TIME_TEXT_COLOR)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension GameTimeView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return minArray.count
        }
        
        return secArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return minArray[row]
        }
        
        return secArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            gameMinLabel.text = minArray[row]
            setGameSeconds()
            
        } else if component == 1 {
            gameSecLabel.text = secArray[row]
            setGameSeconds()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = gameMinLabel.getTextColor()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            initPickerLabel4Pad(label)
        case .phone:
            fallthrough
        default:
            initPickerLabel4Phone(label)
        }
        
        if component == 0 {
            label.text = minArray[row]
        } else if component == 1 {
            label.text = secArray[row]
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 150
        case .phone:
            fallthrough
        default:
            return 60
        }
    }
    
    func initPickerLabel4Phone(_ label: UILabel) {
        
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100)
        
        label.font =  UIFont(name: "DigitalDismay", size: 60)
    }
    
    func initPickerLabel4Pad(_ label: UILabel) {
        
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 210)
        
        label.font =  UIFont(name: "DigitalDismay", size: 150)
    }
    
    func setGameSeconds() {
        let min = Int(gameMinLabel.text!)
        let sec = Int(gameSecLabel.text!)
        gameSeconds = min!*60 + sec!
        oldGameSeconds = gameSeconds
    }
    
    func getColorCollectionViewHeight() -> CGFloat {
        if isLandscape {
            return 44.0
        } else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 44.0
            } else {
                return 92.0
            }
        }
    }
    
    func getColorCollectionViewTitlePosX() -> CGFloat {
        if isLandscape {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 15.0
            } else {
                return 60.0
            }
        } else {
            return 15.0
        }
    }
    
    func getColorCollectionViewPosX() -> CGFloat {
       if isLandscape {
           if UIDevice.current.userInterfaceIdiom == .pad {
               return 0
           } else {
               return 60.0
           }
       } else {
           return 0
       }
   }
    
    func setSelectedTextColor(color: UIColor) {
        self.gameMinLabel.textColor = color
        self.gameColonLabel.textColor = color
        self.gameSecLabel.textColor = color
        self.pickerMinLabel.textColor = color
        self.pickerSecLabel.textColor = color
        self.picker.reloadAllComponents()
    }
}
