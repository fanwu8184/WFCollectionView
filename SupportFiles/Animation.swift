//
//  Animation.swift
//  workDictionary
//
//  Created by Fan Wu on 10/30/18.
//  Copyright © 2018 8184. All rights reserved.
//

import Foundation
import UIKit

class Animation {
    static func generalAnimate(animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: animations, completion: completion)
    }
}
