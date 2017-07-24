//
//  GKWYMusicViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYMusicViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = UIColor.black.withAlphaComponent(0.5)
        
        addChildVCs()
    }

    fileprivate func addChildVCs() {
        addChildVC(vc: GKWYMusicFindViewController(), title: "发现音乐", imageName: "discovery")
        addChildVC(vc: GKWYMusicMineViewController(), title: "我的音乐", imageName: "music")
        addChildVC(vc: GKWYMusicFriendViewController(), title: "朋友", imageName: "friend")
        addChildVC(vc: GKWYMusicAccountViewController(), title: "账号", imageName: "account")
    }
    
    fileprivate func addChildVC(vc: UIViewController, title: String, imageName: String) {
        vc.tabBarItem.title = title
        
        let normalImageName = "cm2_btm_icn_" + imageName;
        let selectImageName = normalImageName + "_prs"
        
        vc.tabBarItem.image = UIImage(named: normalImageName)
        vc.tabBarItem.selectedImage = UIImage(named: selectImageName)
        
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .selected)
        
        let nav = UINavigationController(rootVC: vc, translationScale: false)
        
        self.addChildViewController(nav)
    }
}
