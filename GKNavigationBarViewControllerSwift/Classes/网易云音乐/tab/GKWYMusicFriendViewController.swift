//
//  GKWYMusicFriendViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYMusicFriendViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "朋友"
        
        self.gk_navBarTintColor = UIColor(red: (200 / 255.0), green: (39 / 255.0), blue: (39 / 255.0), alpha: 1.0)
        
        let backItem = UIBarButtonItem(title: "返回", imageName: "btn_back_white", target: self, action: #selector(backAction))
        let moreItem = UIBarButtonItem(title: "更多", target: self, action: #selector(moreAction))
        self.gk_navLeftBarButtonItems = [backItem, moreItem]
        
        self.view.backgroundColor = UIColor.white
        
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(closeAction))
    }
    
    @objc fileprivate func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func moreAction() {
        let detailVC = GKWYMusicDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc fileprivate func closeAction() {
        dismiss(animated: true, completion: nil)
    }
}
