//
//  GKTab003ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKTab003ViewController: GKTabBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gk_navigationItem.title = "tab003"
        self.gk_navBarTintColor = UIColor.magenta
        
        self.contentText = "我设置了UITabBarController的滑动范围为距离屏幕左边100像素"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.gk_popMaxAllowedDistanceToLeftEdge = 100
    }
    
    override func pushAction() {
        let demo003VC = GKDemo003ViewController()
        navigationController?.pushViewController(demo003VC, animated: true)
    }
}
