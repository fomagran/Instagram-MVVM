//
//  Protocols.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/03.
//


protocol AuthentificationDelegate:class {
    func didLoginCompleted()
}

protocol MyPageHeaderDelegate:class {
    func header(_ profileHeader: MyPageHeaderCell, didTapActionButtonFor user:User)
}
