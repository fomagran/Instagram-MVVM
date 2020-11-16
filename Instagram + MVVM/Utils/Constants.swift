//
//  Constants.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/02.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWINGS = Firestore.firestore().collection("followings")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notification")
