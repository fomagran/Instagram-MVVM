//
//  PostViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/10.
//

import UIKit

struct PostViewModel {
    var post:Post
    
    var imageUrl:URL? { return URL(string: post.imageUrl)}
    
    var caption:String { return post.caption}
    
    var likes:Int { return post.likes}
    
    var userProfileImageUrl:URL? { return URL(string: post.imageUrl)}
    
    var username:String { return post.ownerUsername}
    
    var likesLabelText:String {
        if post.likes > 1 {
            return "\(post.likes) likes"
        }else{
            return "\(post.likes) like"
        }
    }
    
    var likeButtonTintColor:UIColor {
        return post.didLike ? .red:.black
    }
    
    var likeButtonImage:UIImage? {
        return post.didLike ?  #imageLiteral(resourceName: "like_selected") :  #imageLiteral(resourceName: "like_unselected")
    }
    
    init(post:Post) {
        self.post = post
    }
}
