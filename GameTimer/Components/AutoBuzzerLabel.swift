//
//  AutoBuzzerLabel.swift
//  GameTimer
//
//  Created by Nobuhiro Harada on 2020/01/08.
//  Copyright © 2020 Nobuhiro Harada. All rights reserved.
//

import UIKit

final class AutoBuzzerLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.text = "AUTO"
        self.textAlignment = .center
        self.textColor = .white
        
        if userdefaults.bool(forKey: BUZEER_AUTO_BEEP) {
            self.alpha = 1.0
        } else {
            self.alpha = 0
        }

        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            checkOrientation4Phone()
        case .pad:
            checkOrientation4Pad()
        default:
            break
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkOrientation4Phone() {
        if isLandscape {
            initPhoneAttrLandscape()
        } else {
            initPhoneAttrPortrait()
        }
    }
    
    func checkOrientation4Pad() {
        
        if isLandscape {
            initPadAttrLandscape()
        } else {
            initPadAttrPortrait()
        }

    }
    
    func initPhoneAttrPortrait() {
        self.bounds = CGRect(x: 0, y: 0, width: 40, height: 20)
        self.font = .boldSystemFont(ofSize: 14.0)
    }
    
    func initPhoneAttrLandscape() {
        self.bounds = CGRect(x: 0, y: 0, width: 40, height: 20)
        self.font = .boldSystemFont(ofSize: 14.0)
    }
    
    func initPadAttrPortrait() {
        self.bounds = CGRect(x: 0, y: 0, width: 40, height: 20)
        self.font = .boldSystemFont(ofSize: 14.0)
    }
    
    func initPadAttrLandscape() {
        self.bounds = CGRect(x: 0, y: 0, width: 40, height: 20)
        self.font = .boldSystemFont(ofSize: 14.0)
    }
    
}
