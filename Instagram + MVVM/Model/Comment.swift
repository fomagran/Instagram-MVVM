//
//  Comment.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/12.
//

import Firebase

struct Comment {
    let uid:String
    let profileImageUrl:String
    let timestamp:Timestamp
    let commentText:String
    let username:String
    
    init(dictionary:[String:Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.commentText = dictionary["commentText"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
    }
}
