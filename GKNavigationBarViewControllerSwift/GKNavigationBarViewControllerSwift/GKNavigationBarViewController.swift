//
//  GKNavigationBarViewController.swift
//  GKNavigationBarViewController-Swift
//
//  Created by QuintGao on 2017/7/17.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

open class GKNavigationBarViewController: UIViewController {

    public lazy var gk_navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
        return navigationBar
    }()
    
    public lazy var gk_navigationItem: UINavigationItem = {
        return UINavigationItem()
    }()
    
    public var gk_navBarTintColor: UIColor? {
        didSet {
            gk_navigationBar.barTintColor = gk_navBarTintColor
        }
    }
    
    public var gk_navBackgroundColor: UIColor? {
        didSet {
            gk_navigationBar.setBackgroundImage(self.imageWith(color: gk_navBackgroundColor!), for: .default)
        }
    }
    
    public var gk_navBackgroundImage: UIImage? {
        didSet {
            gk_navigationBar.setBackgroundImage(gk_navBackgroundImage, for: .default)
        }
    }
    
    public var gk_tintColor: UIColor? {
        didSet {
            gk_navigationBar.tintColor = gk_tintColor
        }
    }
    
    public var gk_navTitleView: UIView? {
        didSet {
            gk_navigationItem.titleView = gk_navTitleView
        }
    }
    
    public var gk_navTitleColor: UIColor? {
        didSet {
            let titleFont = (gk_navTitleFont != nil) ? gk_navTitleFont : GKNavigationBarConfigure.shared.titleFont
            gk_navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: gk_navTitleColor!, NSFontAttributeName: titleFont!]
        }
    }
    
    public var gk_navTitleFont: UIFont? {
        didSet {
            let titleColor = (gk_navTitleColor != nil) ? gk_navTitleColor : GKNavigationBarConfigure.shared.titleColor
            gk_navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColor!, NSFontAttributeName: gk_navTitleFont!]
        }
    }
    
    public var gk_navLeftBarButtonItem: UIBarButtonItem? {
        didSet {
            gk_navigationItem.leftBarButtonItem = gk_navLeftBarButtonItem
        }
    }
    
    public var gk_navLeftBarButtonItems: [UIBarButtonItem]? {
        didSet {
            gk_navigationItem.leftBarButtonItems = gk_navLeftBarButtonItems
        }
    }
    
    public var gk_navRightBarButtonItem: UIBarButtonItem? {
        didSet {
            gk_navigationItem.rightBarButtonItem = gk_navRightBarButtonItem
        }
    }
    
    public var gk_navRightBarButtonItems: [UIBarButtonItem]? {
        didSet {
            gk_navigationItem.rightBarButtonItems = gk_navRightBarButtonItems
        }
    }
    
    // MARK: - 方法的重写
    override open var title: String? {
        didSet {
            self.gk_navigationItem.title = title
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        setupCustomNavBar()
        
        setupNavBarAppearance()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !gk_navigationBar.isHidden {
            view.bringSubview(toFront: gk_navigationBar)
        }
    }
}

extension GKNavigationBarViewController {
    // MARK: - 私有方法
    
    // 设置自定义导航条
    fileprivate func setupCustomNavBar() {
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(self.gk_navigationBar)
        
        gk_navigationBar.isTranslucent = false
        
        gk_navigationBar.items = [gk_navigationItem]
    }
    
    // 设置导航条外观
    fileprivate func setupNavBarAppearance() {
        gk_navBarTintColor = GKNavigationBarConfigure.shared.barTintColor
    }
    
    // 颜色 -> 图片
    fileprivate func imageWith(color: UIColor?) -> UIImage{
        return imageWith(color: color, size: CGSize(width: 1.0, height: 1.0))
    }
    
    fileprivate func imageWith(color: UIColor?, size: CGSize) -> UIImage{
        
        guard let color = color else { return UIImage() }
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}
