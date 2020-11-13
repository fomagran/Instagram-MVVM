//
//  MainCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/28.
//

import UIKit



class MainCell:UICollectionViewCell {
    
    //MARK: 프로퍼티
    
    weak var delegate:MainCellDelegate?
    
    var viewModel:PostViewModel? {
        didSet { configure() }
    }

    private let profileImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var usernameButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        
        return button
    }()
    
    private let postImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
     lazy var likeButton:UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapLikeBtn), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapCommentBtn), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private lazy var likesLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12,paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor,paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top:profileImageView.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionButtons()
        
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    
    @objc func didTapCommentBtn() {
        guard let viewModel = viewModel else { return }
        self.delegate?.cell(self,wantsToShowCommentFor: viewModel.post)
    }
    @objc func didTapUsername() {
        print("DEBUG : did tap username")
    }
    
    @objc func didTapLikeBtn(){
        guard let viewModel = viewModel else {return}
        delegate?.cell(self, didLike: viewModel.post)
    }
    //MARK: Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
        likesLabel.text = viewModel.likesLabelText
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        
    }
    
    func configureActionButtons() {
         var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top:postImageView.bottomAnchor,width: 120,height: 50)
    }
}
