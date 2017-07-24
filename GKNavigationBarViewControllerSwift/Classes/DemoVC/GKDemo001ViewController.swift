//
//  GKDemo001ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKDemo001ViewController: GKDemoBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "控制器001"
        
        self.view.backgroundColor = UIColor.white
        self.gk_navBarTintColor = UIColor.blue
        
        self.gk_navRightBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(dismissed))
        
        let btn = UIButton()
        btn.frame = CGRect(x: 100, y: 400, width: 60, height: 20)
        btn.backgroundColor = UIColor.black
        btn.setTitle("Push", for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc fileprivate func dismissed() {
        if (self.tabBarController?.isKind(of: GKDemo005ViewController.self))! {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc fileprivate func btnAction() {
        let demo002VC = GKDemo002ViewController()
        demo002VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(demo002VC, animated: true)
    }
}
