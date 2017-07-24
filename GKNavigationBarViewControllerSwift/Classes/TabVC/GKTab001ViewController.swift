//
//  GKTab001ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKTab001ViewController: GKTabBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navigationItem.title = "tab001"
        
        self.gk_navBarTintColor = UIColor.cyan
        
        self.contentText = "我禁止了UITabBarController的滑动返回手势。\n我push的时候不隐藏tabbar"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 注意，这里必须在viewDidAppear中设置
        self.tabBarController?.gk_interactivePopDisabled = true
    }
    
    override func pushAction() {
        let demo001VC = GKDemo001ViewController()
        navigationController?.pushViewController(demo001VC, animated: true)
    }
}
