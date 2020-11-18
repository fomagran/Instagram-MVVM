//
//  CommentController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/11.
//

import UIKit

private let reuseIdentifier = "CommentCell"

class CommentController: UICollectionViewController {
    
    //MARK:Propeties
    private var comments = [Comment]()
    
    private let post:Post
    
    private lazy var commentInputView:CommentInputAccesoryView =  {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CommentInputAccesoryView(frame: frame)
        view.delegate = self
        return view
    }()
    
    
    //MARK:LifeCycle
    
    init(post:Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       configure()
        fetchComments()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //new
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    
    //new
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK:API
    func fetchComments() {
        CommentService.fetchComment(postId: post.postId) { (comments) in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Helpers
    
    func configure() {
        self.collectionView.backgroundColor = .white
        self.collectionView!.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //키보드 사라지게하기
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive

    }

}

// MARK: UICollectionViewDelegate
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = comments[indexPath.row].uid
        UserService.fetchUser(uid: uid) { (user) in
            let controller = MyPageController(user:user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: UICollectionViewDataSource
extension CommentController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return comments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension CommentController:UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(width: view.frame.width).height + 16
        return CGSize(width: view.frame.size.width, height: height)
    }
}


//MARK: CommentInputAccesoryViewDelegate
extension CommentController:CommentInputAccesoryViewDelegate {
 
    
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        guard let tab = self.tabBarController as? TabBarController else { return  }
        showLoader(true)
        guard let user = tab.user else { return  }
        CommentService.uploadComment(comment: comment, postID: post.postId, user: user) { (error) in
            self.showLoader(false)
            inputView.clearCommentTextView()
            
            NotificationService.uploadNotification(toUid: self.post.ownerUid, type: .comment ,post:self.post, fromUser: user)
            
        }
       
    }
    
    
}
