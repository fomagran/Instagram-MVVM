//
//  PostViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/10.
//

import UIKit

struct PostViewModel {
    private let post:Post
    
    var imageUrl:URL? { return URL(string: post.imageUrl)}
    
    var caption:String { return post.caption}
    
    var likes:Int { return post.likes}
    
    init(post:Post) {
        self.post = post
    }
}
