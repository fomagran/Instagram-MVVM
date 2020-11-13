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

protocol UploadPostControllerDelegate:class{
    func controllerDidFinishUploadingPost(_ controller:UploadPostController)
}

protocol MainCellDelegate:class {
    func cell(_ cell : MainCell,wantsToShowCommentFor post: Post)
    func cell(_ cell : MainCell,didLike post:Post)
}

protocol CommentInputAccesoryViewDelegate:class {
    func inputView(_ inputView:CommentInputAccesoryView,wantsToUploadComment comment:String)
}
