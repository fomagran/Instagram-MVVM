//
//  NotificationService.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/16.
//

import Firebase

struct NotificationService {
    static func uploadNotification(toUid uid:String,type:NotificationType, post:Post? = nil,fromUser : User) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return  }
        guard uid != currentUid else { return  }
        
        let documentRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
        var data:[String:Any] = ["timestamp":Timestamp(date: Date()),
                                 "uid":currentUid,
                                 "type":type.rawValue,
                                 "id":documentRef.documentID,
                                 "username":fromUser.username,
                                 "userProfileImageUrl":fromUser.profileImageUrl]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        documentRef.setData(data)
    }
    
    static func fetchNotifications(completion:@escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return  }
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").getDocuments { (snapshot, _) in
            guard let documents = snapshot?.documents else {return}
            let notifications = documents.map{Notification(dictionary: $0.data())}
            completion(notifications)
        }
    }
}

