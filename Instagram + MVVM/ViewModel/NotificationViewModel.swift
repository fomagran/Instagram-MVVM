//
//  NotificationViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/16.
//

import UIKit

struct NotificationViewModel {
    
     var notification:Notification
    
    init(notification:Notification) {
        self.notification = notification
    }
    
    var postImageUrl:URL? { return URL(string: notification.postImageUrl ?? "") }
    
    var profileImageUrl:URL? { return URL(string: notification.userProfileImageUrl)}
    
    var notificationMessage:NSAttributedString {
        
        let username = notification.username
        let message = notification.type.notificationMessage
        
        let attributedText = NSMutableAttributedString(string: "\(username)",attributes: [.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSMutableAttributedString(string: " \(message)",attributes: [.font:UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSMutableAttributedString(string: "  2m",attributes: [.font:UIFont.systemFont(ofSize: 12),.foregroundColor:UIColor.lightGray]))
        return attributedText
        
        
    }
    
    var shouldHidePostImage: Bool { return self.notification.type == .follow}
    
    var followButtonText:String { return notification.isUserFollowed ? "Following":"Follow"}
    
    var followButtonBackgroundColor:UIColor {return notification.isUserFollowed ?.white :.systemBlue }
    
    var followButtonTextColor:UIColor { return notification.isUserFollowed ?  .black :. white }
    
    
    }
