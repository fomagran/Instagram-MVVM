//
//  CommentCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/11.
//

import UIKit

class CommentCell: UICollectionViewCell {
    //MARK: Properties
    
    private let profileImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private let commentLabel:UILabel = {
       let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "fomagran  ", attributes: [.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "안녕하세요 포마그랜입니다.",attributes:[.font:UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedString
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 8)
        profileImageView.layer.cornerRadius = 40/2
        profileImageView.setDimensions(height: 40, width: 40)
        
        addSubview(commentLabel)
        
        commentLabel.centerY(inView: profileImageView,leftAnchor: profileImageView.rightAnchor,paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
