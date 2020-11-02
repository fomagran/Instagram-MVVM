//
//  MyPageHeaderViewModel.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/02.
//

import Foundation

struct MyPageHeaderViewModel {
    
    let user :User
    
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
