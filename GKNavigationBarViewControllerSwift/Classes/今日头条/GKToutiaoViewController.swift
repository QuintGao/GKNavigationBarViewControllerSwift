//
//  GKToutiaoViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKToutiaoViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = UIColor.white
        
        addChildVCs()
    }

    fileprivate func addChildVCs() {
        addChildVC(vc: GKToutiaoHomeViewController(), title: "首页", imageName: "Home")
        addChildVC(vc: GKToutiaoVideoViewController(), title: "视频", imageName: "Home")
        addChildVC(vc: GKToutiaoMicroViewController(), title: "微头条", imageName: "Home")
        addChildVC(vc: GKToutiaoMineViewController(), title: "我的", imageName: "Home")
    }
    
    fileprivate func addChildVC(vc: UIViewController, title: String, imageName: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: (212 / 255.0), green: (25 / 255.0), blue: (37 / 255.0), alpha: 1.0)], for: .selected)
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        
        self.addChildViewController(vc)
    }
}
