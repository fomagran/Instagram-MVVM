//
//  CommentViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/12.
//

import UIKit

struct CommentViewModel {
    
    private let comment:Comment
    
    var profileImageUrl:URL? {
        return URL(string: comment.profileImageUrl)
    }
    
    func commentLabelText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(comment.username)  ", attributes: [.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "\(comment.commentText)",attributes:[.font:UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
    
    init(comment:Comment) {
        self.comment = comment
    }
    
    func size(width:CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        //new
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        //new
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
