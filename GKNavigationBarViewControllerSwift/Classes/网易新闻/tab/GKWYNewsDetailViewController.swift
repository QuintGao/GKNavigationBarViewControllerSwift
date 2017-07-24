//
//  GKWYNewsDetailViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYNewsDetailViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "详情"
        self.gk_navTitleColor = UIColor.black
        self.gk_navBackgroundColor = UIColor.white
        
        self.view.backgroundColor = UIColor.white
        
        // 设置push动画的代理
        self.gk_pushDelegate = self
        
        let pageImage = UIImageView()
        pageImage.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64)
        pageImage.image = UIImage(named: "news_detailpage")
        self.view.addSubview(pageImage)
        
        pageImage.isUserInteractionEnabled = true
        pageImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageAction)))
    }

    @objc fileprivate func pageAction() {
        let commentVC = GKWYNewsCommentViewController()
        navigationController?.pushViewController(commentVC, animated: true)
    }
}

// MARK: - GKViewControllerPushDelegate

extension GKWYNewsDetailViewController: GKViewControllerPushDelegate {
    func pushToNextViewController() {
        pageAction()
    }
}

