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
    
    private lazy var commentInputView:CommentInputAccesoryView =  {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CommentInputAccesoryView(frame: frame)
        view.delegate = self
        return view
    }()
    
    
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       configure()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //미해결
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    
    //미해결
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: Helpers
    
    func configure() {
        self.collectionView.backgroundColor = .white
        self.collectionView!.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

}

// MARK: UICollectionViewDelegate

// MARK: UICollectionViewDataSource
extension CommentController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension CommentController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
}


//MARK: CommentInputAccesoryViewDelegate
extension CommentController:CommentInputAccesoryViewDelegate {
    
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        inputView.clearCommentTextView()
    }
    
    
}
