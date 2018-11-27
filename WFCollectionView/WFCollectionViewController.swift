//
//  WFCollectionViewController.swift
//  workDictionary
//
//  Created by Fan Wu on 11/19/18.
//  Copyright © 2018 8184. All rights reserved.
//

import UIKit

class WFCollectionViewController: UIViewController {
    
    let textArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I" , "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    lazy var wfCollections = textArray.map { (text) -> WFColection in
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = UIColor.magenta
        let wfCollection = WFColection(contentView: label)
        return wfCollection
    }
    
    let aaa: WFColection = {
        let l = UILabel()
        l.text = "A"
        l.textAlignment = .center
        l.backgroundColor = .green
        let wfCollection = WFColection(contentView: l)
        return wfCollection
    }()
    
    let bbb: WFColection = {
        let l = UILabel()
        l.text = "B"
        l.textAlignment = .center
        l.backgroundColor = .green
        let wfCollection = WFColection(contentView: l)
        return wfCollection
    }()
    
    let ccc: WFColection = {
        let l = UILabel()
        l.text = "C"
        l.textAlignment = .center
        l.backgroundColor = .green
        let wfCollection = WFColection(contentView: l)
        return wfCollection
    }()
    
    lazy var wfCollectionView = WFCollectionView(wfCollections)
    var wfCollectionViewBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(wfCollectionView)
        wfCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        wfCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        wfCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        wfCollectionViewBottomConstraint = wfCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        wfCollectionViewBottomConstraint?.isActive = true
        
        //Add Bar Buttons
        let updateContent = UIBarButtonItem(title: "UC", style: .done, target: self, action: #selector(updateC))
        let changeFactors = UIBarButtonItem(title: "CF", style: .done, target: self, action: #selector(changeF))
        let changeLayout = UIBarButtonItem(title: "CL", style: .done, target: self, action: #selector(changeL))
        let deleteSize = UIBarButtonItem(title: "DS", style: .done, target: self, action: #selector(changeDS))
        let stopButton = UIBarButtonItem(title: "SB", style: .done, target: self, action: #selector(changeSB))
        let wigglingMode = UIBarButtonItem(title: "WM", style: .done, target: self, action: #selector(changeWM))
        let addItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(insert))
        
        navigationItem.rightBarButtonItems  = [updateContent, changeFactors, changeLayout, deleteSize, stopButton, wigglingMode, addItem]
        
        //wfCollectionView.deleteButtonRadius = 20
    }
    
    var switchStatus = true
    
    @objc func updateC() {
        if switchStatus {
            wfCollectionView.wfCollections = [ccc, bbb, aaa]
        } else {
            wfCollectionView.wfCollections = wfCollections
        }
        switchStatus = !switchStatus
    }
    
    @objc func changeF() {
        if switchStatus {
            wfCollectionView.widthFactorOfCell = 1
            wfCollectionView.HeightFactorOfCell = 5
        } else {
            wfCollectionView.widthFactorOfCell = 3.5
            wfCollectionView.HeightFactorOfCell = 3
        }
        switchStatus = !switchStatus
    }
    
    @objc func changeL() {
        if switchStatus {
            if let flowLayout = wfCollectionView.contentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = 0
            }
        } else {
            if let flowLayout = wfCollectionView.contentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 10
                flowLayout.minimumInteritemSpacing = 10
            }
        }
        switchStatus = !switchStatus
    }
    
    @objc func changeDS() {
        if switchStatus {
            wfCollectionView.deleteButtonRadius = 5
            wfCollectionView.deleteButtonBackgroundColor = .blue
        } else {
            wfCollectionView.deleteButtonRadius = 15
            wfCollectionView.deleteButtonBackgroundColor = .lightGray
        }
        switchStatus = !switchStatus
    }
    
    @objc func changeSB() {
        if switchStatus {
            wfCollectionView.stopAllWigglingButtonRadius = 20
            wfCollectionView.getStopAllWigglingButton().backgroundColor = .blue
        } else {
            wfCollectionView.stopAllWigglingButtonRadius = 15
            wfCollectionView.getStopAllWigglingButton().backgroundColor = .green
        }
        switchStatus = !switchStatus
    }
    
    @objc func changeWM() {
        wfCollectionView.cellsWigglingMode = switchStatus
        switchStatus = !switchStatus
    }
    
    @objc func insert() {
        if switchStatus {
            wfCollectionView.insertItem(wfCollection: ccc, at: IndexPath(item: 0, section: 0))
        } else {
            wfCollectionView.insertItem(wfCollection: aaa)
        }
        switchStatus = !switchStatus
    }
}
