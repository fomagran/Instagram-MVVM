//
//  MyPageController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//

import UIKit

class MyPageController: UICollectionViewController {
    var user :User? {
        didSet{
            collectionView.reloadData()
        }
    }
    private let cellIdentifier = "MyPagePhotoCell"
    private let cellHeaderIdentifier = "MyPageHeaderCell"
    
    
    //MARK:라이픅사이클
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchUser()
    }
    
    //MARK: API
    func fetchUser() {
        UserService.fetchUser { (user) in
            self.user = user
            self.navigationItem.title = self.user?.username
        }
    }
    
    //MARK: HELPERS
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(MyPagePhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(MyPageHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellHeaderIdentifier)
    }
}

//MARK: 콜렉션뷰 딜리게이트
extension MyPageController {
    
}

//MARK: 콜렉션뷰 데이터소스
extension MyPageController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyPagePhotoCell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellHeaderIdentifier, for: indexPath) as! MyPageHeaderCell
        if let user = user {
            cell.viewModel = MyPageHeaderViewModel(user: user)
        }
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
        
        let width = (view.frame.width - 2)/3
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
