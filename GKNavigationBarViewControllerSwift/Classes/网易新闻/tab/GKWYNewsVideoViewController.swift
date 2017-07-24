//
//  GKWYNewsVideoViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYNewsVideoViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "视频"
        
        self.view.backgroundColor = UIColor.white
        
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(closeAction))
    }
    
    @objc fileprivate func closeAction() {
        dismiss(animated: true, completion: nil)
    }

}
