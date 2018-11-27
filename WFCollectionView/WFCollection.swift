//
//  WFCollection.swift
//  workDictionary
//
//  Created by Fan Wu on 11/22/18.
//  Copyright © 2018 8184. All rights reserved.
//

import Foundation
import UIKit

class WFColection {
    var contentView: UIView
    var isWiggling: Bool
    
    init(contentView: UIView, isWiggling: Bool = false) {
        self.contentView = contentView
        self.isWiggling = isWiggling
    }
}
