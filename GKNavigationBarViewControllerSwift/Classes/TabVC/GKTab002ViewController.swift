//
//  GKTab002ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKTab002ViewController: GKTabBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navigationItem.title = "tab002"
        
        self.gk_navBarTintColor = UIColor.orange
        
        self.contentText = "我禁止了UITabBarController的全屏滑动手势，可使用边缘滑动返回。\n我push的时候隐藏tabbar"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.gk_fullScreenPopDisabled = true
    }
    
    override func pushAction() {
        let demo002VC = GKDemo002ViewController()
        demo002VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(demo002VC, animated: true)
    }
}
