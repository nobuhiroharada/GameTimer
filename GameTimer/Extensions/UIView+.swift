//
//  UIView+.swift
//  GameTimer
//
//  Created by Nobuhiro Harada on 2020/01/07.
//  Copyright © 2020 Nobuhiro Harada. All rights reserved.
//

import UIKit

extension UIView {
    
    func topViewController() -> UIViewController? {
        var vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        
        while vc?.presentedViewController != nil {
            vc = vc?.presentedViewController
        }
        return vc
    }
}
