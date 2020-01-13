//
//  ViewController.swift
//  GameTimer
//
//  Created by Nobuhiro Harada on 2019/04/29.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    var gameTimeView  = GameTimeView()
    var buzzerPlayer: AVAudioPlayer?
    
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
        
        let buzzerURL = Bundle.main.bundleURL.appendingPathComponent("buzzer.mp3")
        
        do {
            try buzzerPlayer = AVAudioPlayer(contentsOf:buzzerURL)
            
            buzzerPlayer?.prepareToPlay()
            buzzerPlayer?.volume = 2.0
            buzzerPlayer?.delegate = self
            
        } catch {
            print(error)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if isLandscape {
            self.gameTimeView.landscape(frame: self.view.frame)
        } else {
            self.gameTimeView.portrait(frame: self.view.frame)
        }
    }
    
}

extension MainViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        gameTimeView.buzzerButton.setImage(UIImage(named: "buzzer-up"), for: .normal)
        
    }
    
}
