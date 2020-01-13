//
//  ColorCollectionViewCell.swift
//  GameTimer
//
//  Created by Nobuhiro Harada on 2020/01/07.
//  Copyright © 2020 Nobuhiro Harada. All rights reserved.
//

import UIKit

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.layer.cornerRadius = 18.0
        self.contentView.layer.masksToBounds = true
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                let shrink = CABasicAnimation(keyPath: "transform.scale")
                //アニメーションの間隔
                shrink.duration = 0.1
                //1.0から0.95に小さくする
                shrink.fromValue = 1.0
                shrink.toValue = 0.85
                //自動で元に戻るか
                shrink.autoreverses = true
                //繰り返す回数を1回にする
                shrink.repeatCount = 1
                //アニメーションが終了した状態を維持する
                shrink.isRemovedOnCompletion = false
                shrink.fillMode = CAMediaTimingFillMode.forwards
                //アニメーションの追加
                self.layer.add(shrink, forKey: "shrink")
            }
        }
    }
    
    public func animateSelectedColor() {
        self.layer.cornerRadius = 18.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 4
    }
    
    public func animateDeselectedColor() {
        self.layer.borderWidth = 0
    }
}

