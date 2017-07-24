//
//  UIBarButtonItem+Extension.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    public convenience init(title: String = "", imageName: String = "", target: AnyObject?, action: Selector) {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
}
