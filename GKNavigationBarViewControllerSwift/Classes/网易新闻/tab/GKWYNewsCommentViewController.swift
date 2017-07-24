//
//  GKWYNewsCommentViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYNewsCommentViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "评论";
        
        self.gk_navTitleColor = UIColor.black;
        
        self.gk_navBackgroundColor = UIColor.white
        
        self.view.backgroundColor = UIColor.white;
        
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 100, width: 100, height: 20)
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
    }

}
