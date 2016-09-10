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
        return CGSize(width: view.frame.width, height: 200)
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
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Leo Galante", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
        
        attributedText.appendAttributedString(NSAttributedString(string: "\nDecember 18 • Ciudad de Mexico • ", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor(red: 149/255, green: 165/255, blue: 166/255, alpha: 1.0)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "world")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        attributedText.appendAttributedString(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    let statusTextView: UITextView = {
        
        let textView = UITextView()
        
        textView.text = "Yo aqui con toda la hueva del mundo :p"
        textView.font = UIFont.systemFontOfSize(14)
        
        return textView
    }()
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.redColor()
        imageView.image = UIImage(named: "img6")
        
        return imageView
    }()
    
    let statusImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "post1")
        imageView.contentMode = .ScaleAspectFit
        
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        
        addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", view: profileImageView, nameLabel)
        addConstraintsWithFormat("H:|[v0]|", view: statusTextView)
        addConstraintsWithFormat("H:|-8-[v0]-8-|", view: statusImageView)
        addConstraintsWithFormat("V:|-8-[v0]", view: nameLabel)
        addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1(30)]-4-[v2(100)]", view: profileImageView, statusTextView, statusImageView)
        
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, view: UIView...) {
        
        var viewDictionary = [String: UIView]()
        
        for (index, view) in view.enumerate() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
        
    }
    
}





