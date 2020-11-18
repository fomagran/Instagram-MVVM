//
//  Notification.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/16.
//

import Firebase

//MARK: Notification Enum
enum NotificationType:Int {
    case like
    case follow
    case comment
    
    var notificationMessage:String{
        switch self {
        case .like: return " liked your post."
        case .follow:return "started following you."
        case .comment:return "commented on your post"
        }
    }
    
}

struct  Notification {
    let uid:String
    var postImageUrl:String?
    var postId:String?
    let timestamp:Timestamp
    let type:NotificationType
    let id:String
    let username:String
    let userProfileImageUrl:String
    
    var isUserFollowed = false
    
    init(dictionary:[String:Any]) {
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
    }
}
