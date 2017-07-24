//
//  GKWYNewsViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYNewsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = UIColor.white
        
        // 统一设置导航栏样式
        let configure = GKNavigationBarConfigure.shared
        configure .setupDefaultConfigure()
        
        // 设置自定义样式
        configure.barTintColor = UIColor(red: (212 / 255.0), green: (25 / 255.0), blue: (37 / 255.0), alpha: 1.0)
        configure.titleColor = UIColor.white
        configure.titleFont = UIFont.systemFont(ofSize: 18)
        
        // 添加子控制器
        addChildVCs()
    }

    fileprivate func addChildVCs() {
        addChildVC(vc: GKWYNewsHomeViewController(), title: "首页", imageName: "Home")
        addChildVC(vc: GKWYNewsNewViewController(), title: "要闻", imageName: "Home")
        addChildVC(vc: GKWYNewsLiveViewController(), title: "直播", imageName: "Home")
        addChildVC(vc: GKWYNewsVideoViewController(), title: "视频", imageName: "Home")
        addChildVC(vc: GKWYNewsProfileViewController(), title: "我", imageName: "Home")
    }
    
    fileprivate func addChildVC(vc: UIViewController, title: String, imageName: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: (212 / 255.0), green: (25 / 255.0), blue: (37 / 255.0), alpha: 1.0)], for: .selected)
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        
        let nav = UINavigationController(rootVC: vc, translationScale: false)
        nav.gk_openScrollLeftPush = true
        
        self.addChildViewController(nav)
    }

}
