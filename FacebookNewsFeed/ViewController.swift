//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by Luis Arias on 07/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import UIKit

let cellId = "cellId"

class FeedController: UICollectionViewController {
    
    var items = ["Item1", "Item1", "Item1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Facebook Feed"

        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //MARK: UICollectionViewDelegate methods
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! FeedCell

        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
}

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Name"
        label.font = UIFont.boldSystemFontOfSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.redColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[v0(44)]-8-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView, "v1": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[v0(44)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
    }
}





