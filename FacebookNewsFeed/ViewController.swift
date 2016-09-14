//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by Luis Arias on 07/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import UIKit

let cellId = "cellId"

protocol Post {
    var name: String? {get set}
    var status: String? {get set}
    var statusImage: UIImage? {get set}
    var profileImage: UIImage? {get set}
    var location: String? {get set}
    var numLikes: Int? {get set}
    var numComments: Int? {get set}
    var date: String? {get set}
}

struct BasicPost: Post {
    var name: String?
    var status: String?
    var statusImage: UIImage?
    var profileImage: UIImage?
    var location: String?
    var numLikes: Int?
    var numComments: Int?
    var date: String?
}

class FeedController: UICollectionViewController {
    
    var posts = [BasicPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postMark = BasicPost(name: "Leo Galante", status: "Mi gato al parecer luce algo asustado, que le habra pasado??", statusImage: UIImage(named: "post1"), profileImage: UIImage(named: "img6"), location: "Mexico city", numLikes: 2345, numComments: 3543, date: "Yesterday at 8:00 pm")
        
        let postJobs = BasicPost(name: "Steve Jobs", status: "Hola el dieño este sera un texto largo de pruba, asi que si quieres saber que es lo que pasa quedate con nosotros y nosotros podremos ayudarte a escoger mejor que puedes hacer de esta manera tu ya no...", statusImage: UIImage(named: "steve_status"), profileImage: UIImage(named: "steve"), location: "Palo alto", numLikes: 463, numComments: 35, date: "5 min")
        
        let postGhandi = BasicPost(name: "Ghandi", status: "La paz no es el fin, es el camino, si queires cambiar al mundo, cambiar primero tu debes", statusImage: UIImage(named: "gandhi_status"), profileImage: UIImage(named: "ghandi"), location: "Nueva Dheli", numLikes: 675, numComments: 45, date: "1 hr")
        
        posts.append(postMark)
        posts.append(postJobs)
        posts.append(postGhandi)

        self.navigationItem.title = "Facebook Feed"

        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //MARK: UICollectionViewDelegate methods
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let feedCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! FeedCell

        feedCell.post = posts[indexPath.item]
        
        return feedCell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if let status = posts[indexPath.item].status {
        
            let rect = NSString(string: status).boundingRectWithSize(CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
            
            let knowHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSizeMake(view.frame.width, rect.height + knowHeight + 24)
        }
        
        return CGSize(width: view.frame.width, height: 400)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}

class FeedCell: UICollectionViewCell {
    
    var post: BasicPost? {
        didSet {
            
            if let post = post {
                let attributedText = NSMutableAttributedString(string: post.name!, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
                
                attributedText.appendAttributedString(NSAttributedString(string: "\n\(post.date!) • \(post.location!) • ", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.rgb(149, green: 165, blue: 166)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "world")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                
                attributedText.appendAttributedString(NSAttributedString(attachment: attachment))
                
                nameLabel.attributedText = attributedText
            }
            
            if let status = post!.status {
                statusTextView.text = status
            }
            
            if let statusImage = post!.statusImage {
                statusImageView.image = statusImage
            }
            
            if let profileImage = post!.profileImage {
                profileImageView.image = profileImage
            }
            
            if let likesAndCommetsLabel = post {
                if let likes = likesAndCommetsLabel.numLikes {
                    likesCommentsLabel.text = NSString(string: "\(String(likes)) likes  ") as String
                }
                
                if let comments = likesAndCommetsLabel.numComments {
                    likesCommentsLabel.text?.appendContentsOf("\(String(comments))K Comments")
                }
            }
        }
        
    }
    
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
        
        return label
    }()
    
    let statusTextView: UITextView = {
        
        let textView = UITextView()
        textView.font = UIFont.systemFontOfSize(14)
        textView.scrollEnabled = false
        textView.editable = false
        
        return textView
    }()
    
    let likesCommentsLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        
        return label
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.rgb(233, green: 228, blue: 232)
        
        return view
    }()
    
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.redColor()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    let statusImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    let likeButton = FeedCell.buttonForTitle("Like", imageName: "like")
    let commentButton = FeedCell.buttonForTitle("Comment", imageName: "comment")
    let shareButton = FeedCell.buttonForTitle("Share", imageName: "share")
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        
        let button = UIButton()
        
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.rgb(155, green: 161, blue: 171), forState: .Normal)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, 8.0, 0.0, 0.0)
        
        return button
        
    }
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        //Horinzontal constraints
        addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", view: profileImageView, nameLabel)
        addConstraintsWithFormat("H:|[v0]|", view: statusTextView)
        addConstraintsWithFormat("H:|[v0]|", view: statusImageView)
        addConstraintsWithFormat("H:|-12-[v0]|", view: likesCommentsLabel)
        addConstraintsWithFormat("H:|-12-[v0]-12-|", view: dividerLineView)
        
        //Button constraints
        addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", view: likeButton, commentButton, shareButton)
        
        //Vertical constraints
        addConstraintsWithFormat("V:|-8-[v0]", view: nameLabel)
        addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", view: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton, commentButton)
        addConstraintsWithFormat("V:[v0(44)]|", view: commentButton)
        addConstraintsWithFormat("V:[v0(44)]|", view: shareButton)
        
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
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





