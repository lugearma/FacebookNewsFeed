//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by Luis Arias on 07/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import UIKit

class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let customCellIdentifier = "customCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(customCellIdentifier, forIndexPath: indexPath) as! CustomCell
        cell.nameLabel.text = names[indexPath.item]
        cell.nameLabelDos.text = names[indexPath.item]
        return cell
    }
    
    let names = ["Jose", "Luis", "Arias", "Jose", "Luis", "Arias"]
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 200)
    }
    
}

class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hola"
        label.font = UIFont(name: "Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameLabelDos: UILabel = {
        let label = UILabel()
        label.text = "Hola"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    func setupViews() {
        backgroundColor = UIColor.redColor()
        
        self.addSubview(nameLabel)
//        self.addSubview(nameLabelDos)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: [.AlignAllBottom], metrics: nil, views: ["v0": nameLabel]))
        
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": nameLabelDos]))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





