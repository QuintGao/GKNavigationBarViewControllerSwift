//
//  GKToutiaoMicroViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKToutiaoMicroViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "微头条"
        
        self.gk_navTitleColor = UIColor.gray
        self.gk_navBackgroundColor = UIColor.orange
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(closeAction))
        
        let pageImage = UIImageView()
        pageImage.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height - 49)
        pageImage.image = UIImage(named: "micro_page")
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
