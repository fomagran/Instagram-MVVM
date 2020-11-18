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
    func cell(_ cell:MainCell,wantsToShowProfile uid :String)
}

protocol CommentInputAccesoryViewDelegate:class {
    func inputView(_ inputView:CommentInputAccesoryView,wantsToUploadComment comment:String)
}

protocol NotificationCellDelegate:class {
    func cell(_ cell: NotificationCell, wantsToFollow uid:String)
    func cell(_ cell: NotificationCell, wantsToUnfollow uid:String)
    func cell(_ cell: NotificationCell, wantsToViewPost postId:String)
}
