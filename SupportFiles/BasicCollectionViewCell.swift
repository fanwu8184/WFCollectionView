//
//  BasicCell.swift
//  workDictionary
//
//  Created by Fan Wu on 10/18/18.
//  Copyright © 2018 8184. All rights reserved.
//

import Foundation
import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
    }
}
