//
//  GKToutiaoHomeViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKToutiaoHomeViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navigationItem.title = "首页"
        
        self.gk_navBarTintColor = UIColor(red: (212 / 255.0), green: (25 / 255.0), blue: (37 / 255.0), alpha: 1.0)
        
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(self.closeAction))
        
        let pageImage = UIImageView()
        pageImage.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64 - 49)
        pageImage.image = UIImage(named: "home_page")
        self.view.addSubview(pageImage)
        
        pageImage.isUserInteractionEnabled = true
        pageImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pageAction)))
    }
    
    @objc fileprivate func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func pageAction() {
        let detailVC = GKToutiaoDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
