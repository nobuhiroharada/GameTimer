//
//  ViewController.swift
//  GameTimer
//
//  Created by Nobuhiro Harada on 2019/04/29.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gameTimeView  = GameTimeView()
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTimeView.frame = self.view.frame
        self.view.addSubview(gameTimeView)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            self.gameTimeView.landscape(frame: self.view.frame)
        case .portrait, .portraitUpsideDown:
            fallthrough
        default:
            self.gameTimeView.portrait(frame: self.view.frame)
        }
    }
    
}

