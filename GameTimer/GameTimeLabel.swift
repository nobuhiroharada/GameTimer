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
        self.textColor = .yellow
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            checkOrientation4Pad()
        case .phone:
            fallthrough
        
        default:
            checkOrientation4Phone()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkOrientation4Phone() {
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            initPhoneAttrLandscape()
        case .portrait, .portraitUpsideDown:
            fallthrough
        default:
            initPhoneAttrPortrait()
        }
    }
    
    func checkOrientation4Pad() {
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            initPadAttrLandscape()
        case .portrait, .portraitUpsideDown:
            fallthrough
        default:
            initPadAttrPortrait()
        }
    }
    
    func initPhoneAttrPortrait() {
        self.bounds = CGRect(x: 0, y: 0, width: 160, height: 140)
        self.font = UIFont(name: "DigitalDismay", size: 150)
    }
    
    func initPhoneAttrLandscape() {
        self.bounds = CGRect(x: 0, y: 0, width: 290, height: 260)
        self.font = UIFont(name: "DigitalDismay", size: 270)
    }
    
    func initPadAttrPortrait() {
        self.bounds = CGRect(x: 0, y: 0, width: 330, height: 270)
        self.font = UIFont(name: "DigitalDismay", size: 300)
    }
    
    func initPadAttrLandscape() {
        self.bounds = CGRect(x: 0, y: 0, width: 500, height: 400)
        self.font = UIFont(name: "DigitalDismay", size: 500)
    }
}
