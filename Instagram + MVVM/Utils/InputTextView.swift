//
//  InputTextView.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/09.
//

import UIKit

class InputTextView: UITextView {

   //MARK: Properties
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeholderLabel.anchor(left:leftAnchor,right: rightAnchor,paddingLeft: 8)
                placeholderLabel.centerY(inView: self)
            }else{
                placeholderLabel.anchor(left:leftAnchor,right: rightAnchor,paddingTop: 6,paddingLeft: 8)
            }
        }
    }
    
    var placeholderText :String? {
        didSet { placeholderLabel.text = placeholderText}
    }
    
   let placeholderLabel:UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: LifeCycle
    
    override init(frame:CGRect,textContainer:NSTextContainer?){
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top:topAnchor,left: leftAnchor,paddingTop: 6,paddingLeft: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    
    @objc func textDidChange(){
        placeholderLabel.isHidden = !text.isEmpty
    }
    
}
