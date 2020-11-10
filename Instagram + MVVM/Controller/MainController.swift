//
//  MainController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//

import UIKit
import Firebase

private let reuseCellIdentifier = "Cell"

class MainController: UICollectionViewController {
    
    //MARK: - Properties
    var post : Post?
    private var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }
    
    //MARK: - Helpers
    
    func fetchPosts() {
        guard post == nil else { return }
        PostService.fetchPosts { (posts) in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    func configureUI(){
        
        collectionView.backgroundColor = .white
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: reuseCellIdentifier)
        if post == nil {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Logout",style: .plain,target: self,action: #selector(logout))
        }
        navigationItem.title = "Feed"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(doRefresh), for: .touchUpInside)
        collectionView.refreshControl = refresher
    }
    
    
    //MARK: - Actions
    @objc func doRefresh() {
        self.posts.removeAll()
        fetchPosts()
    }
    @objc func logout(){
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? TabBarController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
}

//MARK: 콜렌션뷰 데이터소스
extension MainController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post != nil ? 1 :posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as! MainCell

            if let post = post {
            cell.viewModel = PostViewModel(post: post)
            } else{
                cell.viewModel = PostViewModel(post: posts[indexPath.row])
            }
        return cell
    }
    
}

//MARK: 콜렌션뷰 플로우레이아웃딜리게이트
extension MainController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width
        var height = width + 8 + 40 + 8
        height += 110
        
        return CGSize(width: width, height: height)
    }
    
}
