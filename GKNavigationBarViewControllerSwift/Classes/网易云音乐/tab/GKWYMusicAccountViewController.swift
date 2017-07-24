//
//  GKWYMusicAccountViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYMusicAccountViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "账号"
        
        self.gk_navBarTintColor = UIColor(red: (200 / 255.0), green: (39 / 255.0), blue: (39 / 255.0), alpha: 1.0)
        
        self.view.backgroundColor = UIColor.white
        
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(closeAction))
        self.gk_navTitleColor = UIColor.green
    }

    @objc fileprivate func closeAction() {
        dismiss(animated: true, completion: nil)
    }

}
