//
//  GKWYNewsHomeViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYNewsHomeViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navTitleView = UIImageView(image: UIImage(named: "news_titleView"))
        
        self.view.backgroundColor = UIColor.white
        
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(closeAction))
        
        let pageImage = UIImageView()
        pageImage.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64 - 49)
        pageImage.image = UIImage(named: "news_homepage")
        self.view.addSubview(pageImage)
        
        pageImage.isUserInteractionEnabled = true
        pageImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageAction)))
    }

    @objc fileprivate func pageAction() {
        let detailVC = GKWYNewsDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc fileprivate func closeAction() {
        dismiss(animated: true, completion: nil)
    }
}
