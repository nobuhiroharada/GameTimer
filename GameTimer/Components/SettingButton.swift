//
//  SettingButton.swift
//  GameTimer
//
//  Created by Nobuhiro Harada on 2019/10/21.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

final class SettingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(named: "setting"), for: .normal)
        self.alpha = 0.3
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            initPhoneAttr()
        case .pad:
            initPadAttr()
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPhoneAttr() {
        self.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
    }
    
    func initPadAttr() {
        self.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
    
}
