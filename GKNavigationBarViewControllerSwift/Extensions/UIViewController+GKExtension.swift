//
//  UIViewController+GKExtension.swift
//  GKNavigationBarViewController-Swift
//
//  Created by QuintGao on 2017/7/17.
//  Copyright © 2017年 高坤. All rights reserved.
//

public let GKViewControllerPropertyChangedNotification: NSNotification.Name = NSNotification.Name(rawValue: "GKViewControllerPropertyChangedNotificaiton")

import UIKit

public protocol GKViewControllerPushDelegate: NSObjectProtocol {
    func pushToNextViewController()
}

extension UIViewController {
    
    // 方法交换
    private static let onceToken = UUID().uuidString
    open override class func initialize() {
        
        guard self == UIViewController.self else {
            return
        }
        
        // Method 'initialize()' defines Objective-C class method 'initialize', which is not guaranteed to be invoked by Swift and will be disallowed in future versions
        
        DispatchQueue.once(token: onceToken) {
            GKNavigationBarConfigure.shared.gk_swizzled_method(self, #selector(viewDidAppear(_:)), #selector(gk_viewDidAppear(_:)))
        }
    }
    
    @objc fileprivate func gk_viewDidAppear(_ animated: Bool) {
        
        // 在每次视图出现时，重新设置当前控制器的手势
        NotificationCenter.default.post(name: GKViewControllerPropertyChangedNotification, object: ["viewController": self])
        
        gk_viewDidAppear(animated)
    }
    
    fileprivate struct AssociatedKeys{
        static var interactivePopDisabled: Bool = false
        static var fullScreenPopDisabled: Bool  = false
        static var popMaxAllowedDistanceToLeftEdge: CGFloat = 0
        static var navBarAlpha: CGFloat = 0
        static var pushDelegate: GKViewControllerPushDelegate? = nil
    }
    
    // 是否禁止当前控制器的滑动返回(包括全屏返回和边缘返回)
    open var gk_interactivePopDisabled: Bool {
        get{
            guard let def = objc_getAssociatedObject(self, &AssociatedKeys.interactivePopDisabled) as? Bool else { return false }
            return def
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.interactivePopDisabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // 当属性改变时，发送通知
            NotificationCenter.default.post(name: GKViewControllerPropertyChangedNotification, object: ["viewController": self])
        }
    }
    
    // 是否禁止当前控制器的全屏滑动返回
    open var gk_fullScreenPopDisabled: Bool {
        get {
            guard let def = objc_getAssociatedObject(self, &AssociatedKeys.fullScreenPopDisabled) as? Bool else { return false }
            return def
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fullScreenPopDisabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // 当属性改变时，发送通知
            NotificationCenter.default.post(name: GKViewControllerPropertyChangedNotification, object: ["viewController": self])
        }
    }
    
    // 全屏滑动时，滑动区域距离屏幕左边的最大位置，默认是0：标识可全屏滑动
    open var gk_popMaxAllowedDistanceToLeftEdge: CGFloat {
        get {
            guard let def = objc_getAssociatedObject(self, &AssociatedKeys.popMaxAllowedDistanceToLeftEdge) as? CGFloat else { return 0 }
            return def
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.popMaxAllowedDistanceToLeftEdge, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // 当属性改变时，发送通知
            NotificationCenter.default.post(name: GKViewControllerPropertyChangedNotification, object: ["viewController": self])
        }
    }
    
    // 导航栏的透明度
    open var gk_navBarAlpha: CGFloat {
        get {
            guard let def = objc_getAssociatedObject(self, &AssociatedKeys.navBarAlpha) as? CGFloat else { return 0 }
            return def
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarAlpha, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            setNavBarAlpha(alpha: newValue)
        }
    }
    
    // push代理
    open var gk_pushDelegate: GKViewControllerPushDelegate? {
        get {
            guard let def = objc_getAssociatedObject(self, &AssociatedKeys.pushDelegate) as? GKViewControllerPushDelegate else { return nil }
            return def
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pushDelegate, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 改变导航栏的透明度
    ///
    /// - Parameter alpha: 透明度
    private func setNavBarAlpha(alpha: CGFloat) {
        var navBar: UINavigationBar? = nil
        
        if self.isKind(of: GKNavigationBarViewController.self) {
            let vc = self as! GKNavigationBarViewController
            navBar = vc.gk_navigationBar
            
            let barBackgroundView = navBar?.subviews.first
            barBackgroundView?.alpha = alpha
        }else {
            navBar = self.navigationController?.navigationBar
            
            let barBackgroundView = navBar?.subviews.first  // _UIBarBackgroundView
            let backgroundImageView = barBackgroundView?.subviews.first // UIImageView
            
            if (navBar?.isTranslucent)! {
                if backgroundImageView != nil {
                    barBackgroundView?.alpha = alpha
                }else {
                    let backgroundEffectView = barBackgroundView?.subviews[1]
                    if backgroundEffectView != nil {
                        backgroundEffectView?.alpha = alpha
                    }
                }
            }else {
                barBackgroundView?.alpha = alpha
            }
        }
        
        // 底部分割线
        navBar?.clipsToBounds = alpha == 0
    }
    
}
