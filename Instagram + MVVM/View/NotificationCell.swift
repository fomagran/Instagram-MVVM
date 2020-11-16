//
//  NotificationCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/16.
//

import UIKit

class NotificationCell:UITableViewCell {
    
    //MARK:Properties
    
    private let profieImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()
    private let infoLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "venom"
        return label
    }()
    
    private let postImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapPostImage))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true

        return imageView
    }()
    
    private let followButton:UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("Loding", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapFollowButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(profieImageView)
        profieImageView.centerY(inView: contentView)
        profieImageView.anchor(left:leftAnchor,paddingLeft: 16)
        profieImageView.setDimensions(height: 48, width: 48)
        profieImageView.layer.cornerRadius = 24
        
        addSubview(infoLabel)
        infoLabel.centerY(inView: profieImageView,leftAnchor: profieImageView.rightAnchor,paddingLeft: 8)
        
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right:rightAnchor,paddingRight: 12,width: 100,height: 32)
        
        addSubview(postImageView)
        postImageView.centerY(inView: self)
        postImageView.anchor(right:rightAnchor,paddingRight: 12,width: 48,height: 48)
        followButton.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    
    @objc func tapFollowButton(){
        
    }
    
    @objc func tapPostImage(){
        
    }
    
    

}