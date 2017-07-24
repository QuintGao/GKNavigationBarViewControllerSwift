//
//  GKDemo003ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKDemo003ViewController: GKDemoBaseViewController {

    override func loadView() {
        super.loadView()
        
        self.view = UIImageView(image: UIImage(named: "001"))
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = true
        
        self.gk_navigationBar.isHidden = true
        
        self.title = "控制器003"
        
        self.view.backgroundColor = UIColor.white
        
        let btn = UIButton(frame: CGRect(x: 100, y: 400, width: 60, height: 20))
        btn.backgroundColor = UIColor.black
        btn.setTitle("Pop", for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc fileprivate func btnAction() {
        navigationController?.popViewController(animated: true)
    }
}
