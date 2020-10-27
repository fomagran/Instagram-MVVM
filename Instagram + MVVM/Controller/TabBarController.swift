//
//  TabBarController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/10/27.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configrueControllers()
    }
    
    func configrueControllers() {
        
        viewControllers = [MainController(),SearchController(),WriteController(),NotificationController(),MyPageController()]
    }
}
