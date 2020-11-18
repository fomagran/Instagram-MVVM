//
//  NotificationCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/16.
//

import UIKit

class NotificationCell:UITableViewCell {
    
    //MARK:Properties
    weak var delegate:NotificationCellDelegate?
    
    var viewModel:NotificationViewModel?{
        didSet { configure() }
    }
    
    private let profieImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()
    private let infoLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var postImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapPostImage))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true

        return imageView
    }()
    
    private lazy var followButton:UIButton =  {
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
     
        addSubview(followButton)
        followButton.centerY(inView: self)
        followButton.anchor(right:rightAnchor,paddingRight: 12,width: 88,height: 32)
        
        addSubview(infoLabel)
        infoLabel.centerY(inView: profieImageView,leftAnchor: profieImageView.rightAnchor,paddingLeft: 8)
        infoLabel.anchor(right:followButton.leftAnchor,paddingLeft: 4)
        
        addSubview(postImageView)
        postImageView.centerY(inView: self)
        postImageView.anchor(right:rightAnchor,paddingRight: 12,width: 48,height: 48)
        followButton.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    
    func configure(){
        
        guard let viewModel = viewModel else { return  }
        profieImageView.sd_setImage(with: viewModel.profileImageUrl)
        postImageView.sd_setImage(with: viewModel.postImageUrl)
        infoLabel.attributedText = viewModel.notificationMessage
        
        followButton.isHidden = !viewModel.shouldHidePostImage
        postImageView.isHidden = viewModel.shouldHidePostImage
        
        followButton.setTitle(viewModel.followButtonText, for: .normal)
        followButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        followButton.backgroundColor = viewModel.followButtonBackgroundColor
    }
    
    //MARK: Actions
    
    @objc func tapFollowButton(){
        
    }
    
    @objc func tapPostImage(){
        guard let postId = viewModel?.notification.postId else { return  }
        delegate?.cell(self, wantsToViewPost: postId)
    }
    
    

}
