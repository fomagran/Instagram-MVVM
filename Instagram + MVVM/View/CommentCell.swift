//
//  CommentCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/11.
//

import UIKit

class CommentCell: UICollectionViewCell {
    //MARK: Properties
    
    var viewModel:CommentViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private let commentLabel = UILabel()
    
    
    //MARK:Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 8)
        profileImageView.layer.cornerRadius = 40/2
        profileImageView.setDimensions(height: 40, width: 40)
        
        
        commentLabel.numberOfLines = 0
        addSubview(commentLabel)
        
        commentLabel.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor,paddingLeft: 8)
        commentLabel.anchor(right:rightAnchor,paddingRight: 8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: Helpers
    func configure(){
        guard let viewModel = viewModel else { return  }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        commentLabel.attributedText = viewModel.commentLabelText()
        
    }
}
