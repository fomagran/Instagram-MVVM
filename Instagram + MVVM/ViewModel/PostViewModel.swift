//
//  PostViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/10.
//

import UIKit

struct PostViewModel {
    let post:Post
    
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
    
    init(post:Post) {
        self.post = post
    }
}
