//
//  MyPagePhotoCell.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/02.
//


import UIKit

class MyPagePhotoCell:UICollectionViewCell {
    var viewModel:PostViewModel? {
        didSet { configure() }
    }
    private let image : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(image)
        image.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        guard let viewModel = viewModel else { return }
        
        image.sd_setImage(with: viewModel.imageUrl)
    }
    
}
