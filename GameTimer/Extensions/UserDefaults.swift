//
//  UserDefaults.swift
//  GameTimer
//
//  Created by Nobuhiro Harada on 2019/10/22.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import Foundation

extension UserDefaults {

    func setState(_ value: TextColorState?, forKey key: String) {
        if let value = value {
            set(value.rawValue, forKey: key)
        } else {
            removeSuite(named: key)
        }
    }

    func getState(forKey key: String) -> TextColorState? {
        if let string = string(forKey: key) {
            return TextColorState(rawValue: string)
        }
        return nil
    }
}
