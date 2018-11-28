//
//  WFCollectionViewCell.swift
//  workDictionary
//
//  Created by Fan Wu on 11/19/18.
//  Copyright © 2018 8184. All rights reserved.
//

import Foundation
import UIKit

class WFCollectionViewCell: BasicCollectionViewCell {
    
    private lazy var deleteButton:UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = deleteButtonRadius
        button.clipsToBounds = true
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return button
    }()
    
    var deleteButtonRadius: CGFloat = 15 {
        didSet {
            if oldValue != deleteButtonRadius {
                updateUI()
            }
        }
    }
    
    var wfCollectionView: WFCollectionView?
    var wfCollection: WFColection? {
        didSet {
            if let collection = wfCollection {
                //needed because of reusable cells
                subviews.forEach {
                    if $0 != deleteButton {
                        $0.removeFromSuperview()
                    }
                }
                setup(collection.contentView)
                bringSubviewToFront(deleteButton)
            }
        }
    }
    
    private lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
    
    private var contentViewTopConstraint: NSLayoutConstraint?
    private var contentViewLeadingConstraint: NSLayoutConstraint?
    private var deleteButtonWidthConstraint: NSLayoutConstraint?
    private var deleteButtonHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        setupDeleteButton()
        addGestureRecognizer(longPressGesture)
    }
    
    private func setup(_ content: UIView) {
        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        content.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        contentViewTopConstraint = content.topAnchor.constraint(equalTo: self.topAnchor, constant: deleteButtonRadius)
        contentViewLeadingConstraint = content.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: deleteButtonRadius)
        contentViewTopConstraint?.isActive = true
        contentViewLeadingConstraint?.isActive = true
    }
    
    private func setupDeleteButton() {
        addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        deleteButtonWidthConstraint = deleteButton.widthAnchor.constraint(equalToConstant: 2 * deleteButtonRadius)
        deleteButtonHeightConstraint = deleteButton.heightAnchor.constraint(equalToConstant: 2 * deleteButtonRadius)
        deleteButtonWidthConstraint?.isActive = true
        deleteButtonHeightConstraint?.isActive = true
    }
    
    private func updateUI() {
        deleteButton.layer.cornerRadius = deleteButtonRadius
        contentViewTopConstraint?.constant = deleteButtonRadius
        contentViewLeadingConstraint?.constant = deleteButtonRadius
        deleteButtonWidthConstraint?.constant = 2 * deleteButtonRadius
        deleteButtonHeightConstraint?.constant = 2 * deleteButtonRadius
    }
    
    func updateWiggling() {
        if wfCollection?.isWiggling == true {
            startWiggle()
            deleteButton.isHidden = false
            addGestureRecognizer(panGesture)
        } else {
            stopWiggle()
            deleteButton.isHidden = true
            removeGestureRecognizer(panGesture)
        }
    }
    
    func getDeleteButton() -> UIButton {
        return deleteButton
    }
    
    @objc func deleteAction() {
        wfCollectionView?.deleteItem(self)
    }
    
    // MARK: Gesture Recognizers' Functions
    @objc private func longPressAction() {
        if wfCollection?.isWiggling == false {
            wfCollection?.isWiggling = true
            updateWiggling()
            if wfCollectionView?.cellsWigglingMode == true {
                wfCollectionView?.updateAllCellsWigglingStatus(true)
            }
            wfCollectionView?.setupStopAllWigglingButton()
        }
    }
    
    @objc private func panAction(_ sender: UIPanGestureRecognizer) {
        wfCollectionView?.moveItem(sender)
    }
}
