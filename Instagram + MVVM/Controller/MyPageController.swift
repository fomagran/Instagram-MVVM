//
//  MyPageController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//

import UIKit

class MyPageController: UICollectionViewController {
    
    //MARK:Properties
    private var posts = [Post]()
    private var user : User

    //MARK:Life Cycle
    init(user:User) {
        self.user = user
        
        //UICollectionViewLayout이라고 써서 약 30분 헤맸다... 잘보자...
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cellIdentifier = "MyPagePhotoCell"
    private let cellHeaderIdentifier = "MyPageHeaderCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        checkIfUserisFollowed()
        fetchUserStats()
        fetchUserPosts()
    }
    //MARK: API
    func checkIfUserisFollowed() {
        UserService.checkIfUserFolloed(uid: user.uid) { (isFollowed) in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserPosts() {
        PostService.fetchUserPosts(forUser: user.uid) { (posts) in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats(){
        UserService.fetchUserStats(uid: user.uid) { (stats) in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
    
    //MARK: HELPERS
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(MyPagePhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(MyPageHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellHeaderIdentifier)
        self.navigationItem.title = self.user.username
    }
}

//MARK: 콜렉션뷰 딜리게이트
extension MyPageController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = MainController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: 콜렉션뷰 데이터소스
extension MyPageController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyPagePhotoCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellHeaderIdentifier, for: indexPath) as! MyPageHeaderCell
        
        cell.delegate = self
        cell.viewModel = MyPageHeaderViewModel(user: user)

        return cell
    }
}

//MARK: 콜렉션뷰 플로우레이아웃딜리게이트
extension MyPageController : UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 2)/3
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 240)
    }
}

//MARK: MyPageHeaderDelegate
extension MyPageController : MyPageHeaderDelegate {
    func header(_ profileHeader: MyPageHeaderCell, didTapActionButtonFor user: User) {
        
        guard let tab = self.tabBarController as? TabBarController else { return  }
        guard let currentUser = tab.user else { return  }
        
        if user.isCurrentUser {
            
        }else if user.isFollowed {
            UserService.unfollow(uid: user.uid) { (error) in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        }else{
            UserService.follow(uid: user.uid) { (error) in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                
                NotificationService.uploadNotification(toUid: user.uid, type: .follow, fromUser: currentUser)
            }
        }
    }
    
    
}
