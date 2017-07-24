//
//  GKWYMusicFindViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYMusicFindViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navBackgroundColor = UIColor(red: (200 / 255.0), green: (39 / 255.0), blue: (39 / 255.0), alpha: 1.0)
        
        self.view.backgroundColor = UIColor.white
        
        self.gk_navLeftBarButtonItem = UIBarButtonItem(imageName: "cm2_toptar_icn_playing", target: self, action: #selector(hideTabBar))
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(closeAction))
        
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 30))
        textField.layer.cornerRadius = 15
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor.white
        textField.placeholder = "搜索音乐、歌手、电台"
        self.gk_navTitleView = textField
        
        let pageImage = UIImageView()
        pageImage.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64 - 49)
        pageImage.image = UIImage(named: "discover_page")
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
















