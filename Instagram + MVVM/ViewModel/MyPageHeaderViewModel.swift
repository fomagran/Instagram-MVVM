//
//  MyPageHeaderViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/02.
//

import UIKit

struct MyPageHeaderViewModel {
    
    let user :User
    
    var fullname :String {
        return user.fullname
    }
    
    var profileImageUrl:URL?{
        return URL(string:user.profileImageUrl)
    }
    
    var followButtonText:String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow "
    }
    var followButtonBackgroundColor : UIColor {
        return user.isCurrentUser ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }
    
    var followButtonTextColor : UIColor {
        return user.isCurrentUser ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var numberOfFollowers:NSAttributedString {
        return attributedStatText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfFolling:NSAttributedString{
        return attributedStatText(value: user.stats.following, label: "following")
    }
    var numberOfPosts:NSAttributedString{
        return attributedStatText(value: 5, label: "posts")
    }
    init(user:User) {
        self.user = user
    }
    
    func attributedStatText(value:Int,label:String) ->NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n",attributes: [.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSMutableAttributedString(string: "\(label)",attributes: [.font:UIFont.systemFont(ofSize: 14),.foregroundColor:UIColor.lightGray]))
        return attributedText
    }
}
