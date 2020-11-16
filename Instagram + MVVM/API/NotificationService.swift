//
//  NotificationService.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/16.
//

import Firebase

struct NotificationService {
    static func uploadNotification(toUid uid:String,type:NotificationType, post:Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return  }
        guard uid != currentUid else { return  }
        
        let documentRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
        var data:[String:Any] = ["timestamp":Timestamp(date: Date()),
                                 "uid":currentUid,
                                 "type":type.rawValue,
                                 "id":documentRef.documentID]
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        documentRef.setData(data)
        
        
      
    }
}

