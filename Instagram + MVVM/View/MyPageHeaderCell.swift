//
//  MyPageHeaderCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/02.
//

import UIKit
import SDWebImage

class MyPageHeaderCell:UICollectionReusableView {
    
    
    //MARK:Properties
    
    weak var delegate: MyPageHeaderDelegate?
    
    var viewModel:MyPageHeaderViewModel? {
        didSet {
            configure()
        }
    }
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var editProfileButton:UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 3
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var postLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var followerLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var followingLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var listButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bookMarkButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var gridButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top:topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 40
        
        addSubview(nameLabel)
        nameLabel.centerX(inView: profileImageView)
        nameLabel.anchor(top:profileImageView.bottomAnchor)
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top:nameLabel.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 16,paddingLeft: 24,paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [postLabel,followerLabel,followingLabel])
        addSubview(stack)
        stack.distribution = .fillEqually
        stack.centerY(inView: profileImageView)
        stack.anchor(left:profileImageView.rightAnchor,right:rightAnchor,paddingLeft:12 ,paddingRight: 12,height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        addSubview(topDivider)
        
        let bottomDivider = UIView()
        topDivider.backgroundColor = .lightGray
        addSubview(bottomDivider)

        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton,listButton,bookMarkButton])
        addSubview(buttonStack)
        buttonStack.distribution = .fillEqually
        buttonStack.anchor(left:leftAnchor,bottom: bottomAnchor,right: rightAnchor,height: 50)
        topDivider.anchor(top: buttonStack.topAnchor,left:leftAnchor,right: rightAnchor,height: 0.5)
        bottomDivider.anchor(top: buttonStack.bottomAnchor,left:leftAnchor,right: rightAnchor,height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:ACTIONS
    @objc func didTapEditProfileButton(){
        guard let viewModel = viewModel else {
            return
        }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
        
    }
    //MARK:HELPERS
    func configure() {
        guard let viewModel = viewModel else {return}
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        editProfileButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileButton.backgroundColor = viewModel.followButtonBackgroundColor
        
        postLabel.attributedText = viewModel.numberOfPosts
        followerLabel.attributedText = viewModel.numberOfFollowers
        followingLabel.attributedText = viewModel.numberOfFolling
    }
}
