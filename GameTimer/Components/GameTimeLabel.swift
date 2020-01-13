//
//  GameTimeLabel.swift
//  basket-manager
//
//  Created by Nobuhiro Harada on 2019/04/14.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

class GameTimeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .center
        self.textColor = self.getTextColor()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            checkOrientation4Pad()
        case .phone:
            checkOrientation4Phone()
        default:
            break
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setParams4PhonePortrait() {
        self.bounds = CGRect(x: 0, y: 0, width: 160, height: 140)
        self.font = UIFont(name: "DigitalDismay", size: 150)
    }
    
    func setParams4PhoneLandscape() {
        self.bounds = CGRect(x: 0, y: 0, width: 290, height: 260)
        self.font = UIFont(name: "DigitalDismay", size: 270)
    }
    
    func setParams4PadPortrait() {
        self.bounds = CGRect(x: 0, y: 0, width: 330, height: 270)
        self.font = UIFont(name: "DigitalDismay", size: 300)
    }
    
    func setParams4PadLandscape() {
        self.bounds = CGRect(x: 0, y: 0, width: 500, height: 400)
        self.font = UIFont(name: "DigitalDismay", size: 500)
    }
    
    func getTextColor() -> UIColor {
        let currentColor: TextColorState = userdefaults.getState(forKey: GAME_TIME_TEXT_COLOR) ?? TextColorState.yellow
        
        switch currentColor {
        case .red:
            return UIColor.red
        case .green:
            return UIColor.green
        case .yellow:
            return UIColor.yellow
        case .white:
            return UIColor.white
        case .systemBlue:
            return UIColor.systemBlue
        case .systemIndigo:
            return UIColor.systemIndigo
        case .systemOrange:
            return UIColor.systemOrange
        case .systemPink:
            return UIColor.systemPink
        case .systemTeal:
            return UIColor.systemTeal
        }
    }
    
//    func getTextColorString() -> String {
//        let currentColor: TextColorState = userdefaults.getState(forKey: GAME_TIME_TEXT_COLOR) ?? TextColorState.yellow
//
//        switch currentColor {
//        case .red:
//            return "setting_red".localized
//        case .green:
//            return "setting_green".localized
//        case .yellow:
//            return "setting_yellow".localized
//        }
//    }
}
