//
//  GKDemo002ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKDemo002ViewController: GKDemoBaseViewController {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height))
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.gray
        scrollView.contentSize = CGSize(width: 0, height: self.view.height + 200)
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.insertSubview(scrollView, at: 0)
        
        self.view.backgroundColor = UIColor.white
        self.gk_navBarTintColor = UIColor.brown
        self.gk_navBarAlpha = 0.0
        
        self.title = "控制器002"
        
        let btn = UIButton(frame: CGRect(x: 100, y: 400, width: 60, height: 20))
        btn.backgroundColor = UIColor.black
        btn.setTitle("Push", for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc fileprivate func btnAction() {
        let demo003VC = GKDemo003ViewController()
        demo003VC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(demo003VC, animated: true)
    }
}

extension GKDemo002ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentY = scrollView.contentOffset.y
        
        if contentY <= 0 {
            gk_navBarAlpha = 0.0
            
            return
        }
        
        // 渐变区间
        if contentY > 0.0 && contentY < 160.0 {
            let alpha = contentY / (160 - 0)
            
            self.gk_navBarAlpha = alpha
        }else {
            self.gk_navBarAlpha = 1.0
        }
    }
}
















