//
//  SearchCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/04.
//

import UIKit
import SDWebImage

class SearchCell:UITableViewCell {
    
    
    var viewModel:SearchViewModel? {
        didSet {
            configure()
        }
    }
    
    private let profieImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()
    
    private let userName:UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "venom"
        return label
    }()
    
    private let fullName:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "the notorious veom"
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profieImageView)
        profieImageView.centerY(inView: contentView)
        profieImageView.anchor(left:leftAnchor,paddingLeft: 16)
        profieImageView.setDimensions(height: 48, width: 48)
        profieImageView.layer.cornerRadius = 24
        
        let stack = UIStackView(arrangedSubviews: [userName,fullName])
        stack.axis = .vertical
        stack.spacing = 5
        addSubview(stack)
        
        stack.centerY(inView: profieImageView,leftAnchor: profieImageView.rightAnchor,paddingLeft: 10)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helpers
    func configure(){
        guard let viewModel = viewModel else {return}
        userName.text = viewModel.username
        fullName.text = viewModel.fullname
        profieImageView.sd_setImage(with: viewModel.profileImageUrl)
    }

}
