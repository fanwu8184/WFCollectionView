//
//  BasicView.swift
//  workDictionary
//
//  Created by Fan Wu on 10/17/18.
//  Copyright © 2018 8184. All rights reserved.
//

import Foundation
import UIKit

class BasicView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}
