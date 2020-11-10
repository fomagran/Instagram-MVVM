//
//  TabBarController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//

import UIKit
import Firebase
import YPImagePicker

class TabBarController: UITabBarController {
    
    private var user:User? {
        didSet {
            guard let user = user else {return}
            configrueControllers(user: user)
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        self.delegate = self
        checkUserLoggedIn()
        fetchUser()
        
    }
    
    
    //MARK:checkUserLogin or Logout
    
    func checkUserLoggedIn(){
        if Auth.auth().currentUser == nil {
            //디스패치큐를 사용하는 이유는 탭바가 나오기전에 유저가 로그인하지 않았다면 LoginController가 실행되야하기 때문에
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: API
    func fetchUser() {
        UserService.fetchUser { (user) in
            self.user = user
        }
    }
    
    
    //MARK:Helpers
    func configrueControllers(user:User) {
        
        let main = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: MainController(collectionViewLayout:UICollectionViewFlowLayout() ))
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        let write = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: WriteController())
        let notification = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        let mypage = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: MyPageController(user: user))
        
        viewControllers = [main,search,write,notification,mypage]
        
    }
    
    func templateNavigationController(unselectedImage:UIImage,selectedImage:UIImage,rootViewController:UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
    
    func didFinishPickingMedia(_ picker:YPImagePicker) {
        picker.didFinishPicking { (items, _) in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else {return}
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentUser = self.user
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
                
            }
        }
    }
}


//MARK: AuthentificationDelegate
extension TabBarController:AuthentificationDelegate {
    func didLoginCompleted() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: UITabBarControllerDelegate
extension TabBarController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
            
        }
        return true
    }
}

//MARK: UploadPostControllerDelegate
extension TabBarController:UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        guard let mainNav = viewControllers?.first as? UINavigationController else { return }
        guard let main = mainNav.viewControllers.first as? MainController else { return }
        main.doRefresh()
    }
}
