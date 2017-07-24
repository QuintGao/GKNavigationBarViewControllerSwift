//
//  GKDemo005ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKDemo005ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.red
        
        addChildVC(vc: GKTab001ViewController(), title: "首页", imageName: "Home")
        addChildVC(vc: GKTab002ViewController(), title: "活动", imageName: "Activity")
        addChildVC(vc: GKTab003ViewController(), title: "我的", imageName: "Mine")
    }

    fileprivate func addChildVC(vc: UIViewController, title: String, imageName: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        
        let nav = UINavigationController(rootVC: vc, translationScale: false)
        nav.gk_openScrollLeftPush = true
        
        self.addChildViewController(nav)
    }
    
}
