//
//  GKTabBaseViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKTabBaseViewController: GKNavigationBarViewController {

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.width = self.view.width - 80
        
        return label
    }()
    
    lazy var pushBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 199, width: 60, height: 20)
        btn.centerX = self.view.centerX
        btn.backgroundColor = UIColor.black
        btn.setTitle("push", for: .normal)
        btn.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        
        return btn
    }()
    
    var contentText: String? {
        didSet {
            self.contentLabel.text = contentText
            self.contentLabel.sizeToFit()
            self.contentLabel.center = self.view.center
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pushBtn)
        
        view.addSubview(contentLabel)
        
        view.backgroundColor = UIColor.white
        
        showBackBtn()
    }
    
    fileprivate func showBackBtn() {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn_back_white"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        btn.sizeToFit()
        
        self.gk_navLeftBarButtonItem = UIBarButtonItem(customView: btn)
    }

    @objc func pushAction() {
        
    }
    
    @objc fileprivate func btnClick(sender: Any) {
        if (self.tabBarController?.isKind(of: GKDemo005ViewController.self))! {
            self.dismiss(animated: true, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
