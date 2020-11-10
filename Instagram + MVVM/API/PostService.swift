//
//  PostService.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/10.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption:String,image:UIImage,completion:@escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { (imageUrl) in
            let data = ["caption":caption,
                        "timestamp":Timestamp(date: Date()),
                        "imageUrl":imageUrl,
                        "likes":0,
                        "ownerUid":uid] as [String:Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion:@escaping([Post])->Void){
        COLLECTION_POSTS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            let posts = snapshot.documents.map{Post(postId:$0.documentID,dictionary:$0.data())}
            completion(posts)
        }
    }
}

