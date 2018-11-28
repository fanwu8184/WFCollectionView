//
//  WFCollectionView.swift
//  workDictionary
//
//  Created by Fan Wu on 11/19/18.
//  Copyright © 2018 8184. All rights reserved.
//

import Foundation
import UIKit

class WFCollectionView: BasicView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "WFCell"
    
    private var wfCollections = [WFColection]()
    var wfCollectionsIsModified: (([WFColection])->())?
    
    var widthFactorOfCell: CGFloat = 3.5 {
        didSet {
            if oldValue != widthFactorOfCell {
                contentCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    var HeightFactorOfCell: CGFloat = 3 {
        didSet {
            if oldValue != HeightFactorOfCell {
                contentCollectionView.collectionViewLayout.invalidateLayout()
            }
        }
    }
    
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(WFCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var deleteButtonBackgroundColor: UIColor! {
        didSet {
            contentCollectionView.visibleCells.forEach { (cell) in
                if let wfCell = cell as? WFCollectionViewCell {
                    wfCell.getDeleteButton().backgroundColor = deleteButtonBackgroundColor
                }
            }
        }
    }
    
    var deleteButtonRadius: CGFloat! {
        didSet {
            contentCollectionView.visibleCells.forEach { (cell) in
                if let wfCell = cell as? WFCollectionViewCell {
                    wfCell.deleteButtonRadius = deleteButtonRadius
                }
            }
        }
    }
    
    var cellsWigglingMode = false
    
    private lazy var stopAllWigglingButton: UIButton = {
        let button = UIButton()
        button.setTitle("S", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = stopAllWigglingButtonRadius
        button.addTarget(self, action: #selector(stopAllWiggling), for: .touchUpInside)
        button.addGestureRecognizer(panGesture)
        return button
    }()
    
    var stopAllWigglingButtonRadius: CGFloat = 15 {
        didSet {
            if oldValue != stopAllWigglingButtonRadius {
                stopAllWigglingButton.layer.cornerRadius = stopAllWigglingButtonRadius
                stopAllWigglingButtonWidthConstraint?.constant = 2 * stopAllWigglingButtonRadius
                stopAllWigglingButtonHeightConstraint?.constant = 2 * stopAllWigglingButtonRadius
            }
        }
    }
    
    private var isStopAllWigglingButtonUp = false
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
    
    private var stopAllWigglingButtonLeadingConstraint: NSLayoutConstraint?
    private var stopAllWigglingButtonTopConstraint: NSLayoutConstraint?
    private var stopAllWigglingButtonWidthConstraint: NSLayoutConstraint?
    private var stopAllWigglingButtonHeightConstraint: NSLayoutConstraint?
    
    convenience init(_ wfCollections: [WFColection]) {
        self.init(frame: .zero)
        self.wfCollections = wfCollections
    }
    
    override func setupViews() {
        super.setupViews()
        setupWfCollectionView()
    }
    
    private func setupWfCollectionView() {
        addSubview(contentCollectionView)
        contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        contentCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        contentCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        contentCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    func setupStopAllWigglingButton() {
        if !isStopAllWigglingButtonUp {
            addSubview(stopAllWigglingButton)
            stopAllWigglingButton.translatesAutoresizingMaskIntoConstraints = false
            stopAllWigglingButtonLeadingConstraint = stopAllWigglingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width - 2 * stopAllWigglingButtonRadius)
            stopAllWigglingButtonTopConstraint =  stopAllWigglingButton.topAnchor.constraint(equalTo: topAnchor, constant: 0)
            stopAllWigglingButtonWidthConstraint = stopAllWigglingButton.widthAnchor.constraint(equalToConstant: 2 * stopAllWigglingButtonRadius)
            stopAllWigglingButtonHeightConstraint = stopAllWigglingButton.heightAnchor.constraint(equalToConstant: 2 * stopAllWigglingButtonRadius)
            stopAllWigglingButtonLeadingConstraint?.isActive = true
            stopAllWigglingButtonTopConstraint?.isActive = true
            stopAllWigglingButtonWidthConstraint?.isActive = true
            stopAllWigglingButtonHeightConstraint?.isActive = true
            isStopAllWigglingButtonUp = true
        }
    }
    
    // MARK: Wiggling And It's Related Button Functions
    func updateAllCellsWigglingStatus(_ wiggle: Bool) {
        wfCollections.forEach { (wfCollection) in
            wfCollection.isWiggling = wiggle
        }
        contentCollectionView.visibleCells.forEach { (cell) in
            if let wfCell = cell as? WFCollectionViewCell {
                wfCell.updateWiggling()
            }
        }
    }
    
    @objc private func stopAllWiggling() {
        updateAllCellsWigglingStatus(false)
        removeStopAllWigglingButton()
    }
    
    private func removeStopAllWigglingButton() {
        stopAllWigglingButton.removeFromSuperview()
        stopAllWigglingButtonLeadingConstraint?.isActive = false
        stopAllWigglingButtonTopConstraint?.isActive = false
        stopAllWigglingButtonWidthConstraint?.isActive = false
        stopAllWigglingButtonHeightConstraint?.isActive = false
        isStopAllWigglingButtonUp = false
    }
    
    func getStopAllWigglingButton() -> UIButton {
        return stopAllWigglingButton
    }
    
    // MARK: Gesture Recognizers' Functions
    @objc private func panAction(_ sender: UIPanGestureRecognizer) {
        if let view = sender.view {
            let translation = sender.translation(in: self)
            stopAllWigglingButtonLeadingConstraint?.constant = view.frame.origin.x + translation.x
            stopAllWigglingButtonTopConstraint?.constant = view.frame.origin.y + translation.y
            sender.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    // MARK: Miscellaneous Functions
    func setContent(_ content: [WFColection]) {
        wfCollections = content
        contentCollectionView.reloadData()
    }
    
    func insertItem(wfCollection: WFColection, at indexPath: IndexPath? = nil) {
        if cellsWigglingMode && wfCollections.first?.isWiggling == true {
            wfCollection.isWiggling = true
        }
        
        contentCollectionView.performBatchUpdates({
            if var indexPath = indexPath {
                if indexPath.row > wfCollections.count {
                    indexPath.row = wfCollections.count
                }
                if indexPath.row < 0 {
                    indexPath.row = 0
                }
                wfCollections.insert(wfCollection, at: indexPath.row)
                contentCollectionView.insertItems(at: [indexPath])
            } else {
                let defaultIndexPath = IndexPath(row: wfCollections.count, section: 0)
                contentCollectionView.insertItems(at: [defaultIndexPath])
                wfCollections.append(wfCollection)
            }
            wfCollectionsIsModified?(wfCollections)
        })
    }
    
    func deleteItem(_ cell: UICollectionViewCell) {
        if let indexPath = contentCollectionView.indexPath(for: cell) {
            contentCollectionView.performBatchUpdates({
                wfCollections.remove(at: indexPath.row)
                wfCollectionsIsModified?(wfCollections)
                contentCollectionView.deleteItems(at: [indexPath])
            })
            
            
            //remove Stop Button if there is no more Delete Button
            var anyMoreDeleteButtonExist =  false
            wfCollections.forEach { (wfCollection) in
                if wfCollection.isWiggling {
                    anyMoreDeleteButtonExist = true
                }
            }
            if !anyMoreDeleteButtonExist {
                removeStopAllWigglingButton()
            }
        }
    }
    
    func moveItem(_ sender: UIPanGestureRecognizer) {
        switch(sender.state) {
        case .began:
            if let selectedIndexPath = contentCollectionView.indexPathForItem(at: sender.location(in: contentCollectionView)) {
                contentCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            }
        case .changed:
            contentCollectionView.updateInteractiveMovementTargetPosition(sender.location(in: contentCollectionView))
        case .ended:
            contentCollectionView.endInteractiveMovement()
        default:
            contentCollectionView.cancelInteractiveMovement()
        }
    }
    
    // MARK: CollectionView Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wfCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let wfCell = cell as? WFCollectionViewCell {
            wfCell.wfCollection = wfCollections[indexPath.row]
            wfCell.wfCollectionView = self
            if deleteButtonRadius != nil {
                wfCell.deleteButtonRadius = deleteButtonRadius
            }
            if deleteButtonBackgroundColor != nil {
                wfCell.getDeleteButton().backgroundColor = deleteButtonBackgroundColor
            }
            wfCell.updateWiggling()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / widthFactorOfCell, height: collectionView.bounds.height / HeightFactorOfCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let wfCollection = wfCollections[sourceIndexPath.row]
        wfCollections.remove(at: sourceIndexPath.row)
        wfCollections.insert(wfCollection, at: destinationIndexPath.row)
        wfCollectionsIsModified?(wfCollections)
    }
}
