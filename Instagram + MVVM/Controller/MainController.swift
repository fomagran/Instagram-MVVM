//
//  MainController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//

import UIKit
import Firebase

class MainController: UICollectionViewController {
    private let reuseCellIdentifier = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        collectionView.backgroundColor = .white
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: reuseCellIdentifier)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Logout",style: .plain,target: self,action: #selector(logout))
        navigationItem.title = "Feed"
    }
    
    //MARK:액션
    @objc func logout(){
        do {
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginController())
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
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as! MainCell
       
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
