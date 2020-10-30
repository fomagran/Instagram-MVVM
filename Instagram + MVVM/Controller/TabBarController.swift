//
//  TabBarController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        configrueControllers()
        checkUserLoggedIn()
    }
    
    
    //MARK:checkUserLogin or Logout
    
    func checkUserLoggedIn(){
        if Auth.auth().currentUser == nil {
            //디스패치큐를 사용하는 이유는 탭바가 나오기전에 유저가 로그인하지 않았다면 LoginController가 실행되야하기 때문에
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func configrueControllers() {
        let main = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: MainController(collectionViewLayout:UICollectionViewFlowLayout() ))
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        let write = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: WriteController())
        let notification = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        let mypage = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: MyPageController())
        
        viewControllers = [main,search,write,notification,mypage]
        
    }
    
    func templateNavigationController(unselectedImage:UIImage,selectedImage:UIImage,rootViewController:UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}
