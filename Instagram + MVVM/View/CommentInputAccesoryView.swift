//
//  CommentInputAccesoryView.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/11.
//

import UIKit

class CommentInputAccesoryView:UIView {
    
    //MARK:PROPERTIES
    
    weak var delegate:CommentInputAccesoryViewDelegate?
    
    private let commentTextView:InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter comment..."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.isScrollEnabled = false
        textView.placeholderShouldCenter = true
        return textView
    }()
    
    private let postButton:UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(tapPostBtn), for: .touchUpInside)
        return button
    }()
    
    //MARK:LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        //new
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top:topAnchor,right: rightAnchor,paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top:topAnchor,left:leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor,right: postButton.leftAnchor,paddingTop: 8,paddingLeft: 8,paddingBottom: 8,paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top:topAnchor,left: leftAnchor,right: rightAnchor,height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //new
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    //MARK: ACTIONS
    @objc func tapPostBtn() {
        self.delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    //MARK: Helpers
    func clearCommentTextView(){
        commentTextView.text = nil
        commentTextView.placeholderLabel.isHidden = false
    }
}
