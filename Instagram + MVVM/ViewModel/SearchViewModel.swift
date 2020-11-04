//
//  SearchViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/04.
//

import Foundation

struct SearchViewModel {
    
    private let user :User
    
    var username:String {
        return user.username
    }
    
    var fullname :String {
        return user.fullname
    }
    
    var profileImageUrl:URL?{
        return URL(string:user.profileImageUrl)
    }
    
    init(user:User) {
        self.user = user
    }
}
