//
//  GKWYMusicDetailViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/20.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKWYMusicDetailViewController: GKNavigationBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "朋友"
        
        self.gk_navBarTintColor = UIColor(red: (200 / 255.0), green: (39 / 255.0), blue: (39 / 255.0), alpha: 1.0)
        
        self.view.backgroundColor = UIColor.white
    }

}
