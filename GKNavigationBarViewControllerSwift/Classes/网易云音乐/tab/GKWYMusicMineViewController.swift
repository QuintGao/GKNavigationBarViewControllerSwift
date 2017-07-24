//
//  GKWYMusicMineViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYMusicMineViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的音乐"
        
        self.gk_navLeftBarButtonItem = UIBarButtonItem(title: "更多", target: self, action: #selector(hideTabBar))
        
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(closeAction))
        
        self.gk_navBarTintColor = UIColor(red: (200 / 255.0), green: (39 / 255.0), blue: (39 / 255.0), alpha: 1.0)
        
        self.gk_navTitleColor = UIColor.white
        self.gk_navTitleFont  = UIFont.systemFont(ofSize: 18.0)
        
        self.view.backgroundColor = UIColor.white
        
        let pageImage = UIImageView()
        pageImage.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64 - 49)
        pageImage.image = UIImage(named: "music_page")
        self.view.addSubview(pageImage)
        
        pageImage.isUserInteractionEnabled = true
        pageImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageAction)))
    }
    @objc fileprivate func pageAction() {
        let detailVC = GKWYMusicDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc fileprivate func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func hideTabBar() {
        let detailVC = GKWYMusicDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
