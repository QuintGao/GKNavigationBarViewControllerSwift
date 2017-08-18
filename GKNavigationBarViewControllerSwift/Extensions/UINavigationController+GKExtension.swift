//
//  GKNavigationController+GKExtension.swift
//  GKNavigationBarViewController-Swift
//
//  Created by QuintGao on 2017/7/17.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

// MARK: - Swizzling 会改变全局状态，所以用 DispatchQueue.once 来确保无论多少线程都只会被执行一次
extension DispatchQueue {
    private static var onceTracker = [String]()
    
    public class func once(token: String, block: () -> Swift.Void) {
        // 保证被 objc_sync_enter 和 objc_sync_exit 包裹的代码可以有序同步地执行
        objc_sync_enter(self)
        defer { // 作用域结束后执行defer中的代码
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) {
            return
        }
        
        onceTracker.append(token)
        block()
    }
}

extension UINavigationController {
    fileprivate struct AssociatedKeys {
        static var defTranslationScale: Bool = false
        static var defOpenScrollLeftPush: Bool = false
        static var defPopGestureDelegate: GKPopGestureRecognizerDelegate = GKPopGestureRecognizerDelegate()
        static var defNavigationDelegate: GKNavigationControllerDelegate = GKNavigationControllerDelegate()
        static var defPanGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
        static var defScreenPanGesture: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer()
    }
    
    // 添加属性
    
    // 导航栏转场时是否缩放,此属性只能在初始化导航栏的时候有效，在其他地方设置会导致错乱
    open var gk_translationScale: Bool {
        get {
            guard let def = objc_getAssociatedObject(self, &AssociatedKeys.defTranslationScale) as? Bool else { return false }
            return def
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defTranslationScale, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 是否开启左滑push操作，默认是NO
    open var gk_openScrollLeftPush: Bool {
        get {
            guard let def = objc_getAssociatedObject(self, &AssociatedKeys.defOpenScrollLeftPush) as? Bool else { return false }
            return def
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defOpenScrollLeftPush, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 手势代理
    fileprivate var popGestureDelegate: GKPopGestureRecognizerDelegate {
        get {
            var delegate = objc_getAssociatedObject(self, &AssociatedKeys.defPopGestureDelegate) as? GKPopGestureRecognizerDelegate
            if delegate == nil {
                delegate = GKPopGestureRecognizerDelegate()
                delegate?.navigationController = self
                delegate?.systemTarget = self.systemTarget()
                delegate?.customTarget = self.navigationDelegate
                
                objc_setAssociatedObject(self, &AssociatedKeys.defPopGestureDelegate, delegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return delegate!
        }
    }
    
    // 导航栏代理
    fileprivate var navigationDelegate: GKNavigationControllerDelegate {
        get {
            var delegate = objc_getAssociatedObject(self, &AssociatedKeys.defNavigationDelegate) as? GKNavigationControllerDelegate
            if delegate == nil {
                delegate = GKNavigationControllerDelegate()
                delegate?.navigationController = self
                delegate?.pushDelegate         = self
                
                objc_setAssociatedObject(self, &AssociatedKeys.defNavigationDelegate, delegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return delegate!
        }
    }
    
    // 全屏滑动手势
    fileprivate var panGesture: UIPanGestureRecognizer {
        get {
            var gesture = objc_getAssociatedObject(self, &AssociatedKeys.defPanGesture) as? UIPanGestureRecognizer
            if gesture == nil {
                gesture = UIPanGestureRecognizer()
                gesture?.maximumNumberOfTouches = 1
                
                objc_setAssociatedObject(self, &AssociatedKeys.defPanGesture, gesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return gesture!
        }
    }
    
    // 屏幕边缘滑动手势
    fileprivate var screenPanGesture: UIScreenEdgePanGestureRecognizer {
        get {
            var gesture = objc_getAssociatedObject(self, &AssociatedKeys.defScreenPanGesture) as? UIScreenEdgePanGestureRecognizer
            if gesture == nil {
                gesture = UIScreenEdgePanGestureRecognizer(target: self.navigationDelegate, action: NSSelectorFromString("panGestureAction:"))
                gesture?.edges = .left
                
                objc_setAssociatedObject(self, &AssociatedKeys.defScreenPanGesture, gesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return gesture!
        }
    }
    
    fileprivate func systemTarget() -> Any {
        let internalTargets = interactivePopGestureRecognizer?.value(forKey: "targets") as? [AnyObject]
        
        guard let internalTarget = internalTargets?.first?.value(forKey: "target") else {
            return self
        }
        
        return internalTarget
    }
    
    // 构造方法
    
    public convenience init(rootVC: UIViewController, translationScale: Bool) {
        self.init(rootViewController: rootVC)
        
        self.gk_translationScale = translationScale
    }
    
    // 方法交换
    private static let onceToken = UUID().uuidString
    open override class func initialize() {
        
        guard self == UINavigationController.self else {
            return
        }
        
        // Method 'initialize()' defines Objective-C class method 'initialize', which is not guaranteed to be invoked by Swift and will be disallowed in future versions
        
        DispatchQueue.once(token: onceToken) {
            GKNavigationBarConfigure.shared.gk_swizzled_method(self, #selector(viewDidLoad), #selector(gk_viewDidLoad))
            
            GKNavigationBarConfigure.shared.gk_swizzled_method(self, #selector(viewDidDisappear(_:)), #selector(gk_viewDidDisappear(_:)))
            
            GKNavigationBarConfigure.shared.gk_swizzled_method(self, #selector(pushViewController(_:animated:)), #selector(gk_pushViewController(_:animated:)))
        }
    }
}

// MARK: - 交换的方法
extension UINavigationController {
    @objc fileprivate func gk_viewDidLoad() {
        // 隐藏系统导航栏
        setNavigationBarHidden(true, animated: false)
        
        // 设置背景色
        view.backgroundColor = UIColor.black
        
        // 设置代理
        self.delegate = self.navigationDelegate
        
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: GKViewControllerPropertyChangedNotification, object: nil)
        
        gk_viewDidLoad()
    }
    
    @objc fileprivate func gk_viewDidDisappear(_ animated: Bool) {
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: GKViewControllerPropertyChangedNotification, object: nil)
        
        gk_viewDidDisappear(animated)
    }
    
    @objc fileprivate func gk_pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 设置默认值
        if viewControllers.count > 0 {
            // 设置返回按钮
            if viewController.isKind(of: GKNavigationBarViewController.self) {
                let vc = viewController as! GKNavigationBarViewController
                vc.gk_navLeftBarButtonItem = UIBarButtonItem(imageName: "btn_back_black", target: self, action: #selector(goBack))
            }
        }
        
        if !viewControllers.contains(viewController) {
            gk_pushViewController(viewController, animated: animated)
        }
    }
    
    @objc fileprivate func goBack() {
        popViewController(animated: true)
    }
}

extension UINavigationController {
    // MARK: - Notification Handle
    @objc fileprivate func handleNotification(notify: Notification) {
        
        let dic = notify.object as! [String: AnyObject]
        
        guard let vc = dic["viewController"] as? UIViewController else { return }
        
        if vc.isKind(of: UIInputViewController.self) {
            return
        }
        
        let isRootVC = vc == viewControllers.first
        
        if vc.gk_interactivePopDisabled {  // 禁止滑动
            interactivePopGestureRecognizer?.delegate  = nil
            interactivePopGestureRecognizer?.isEnabled = false
        }else if (vc.gk_fullScreenPopDisabled) {  // 禁止全屏滑动
            interactivePopGestureRecognizer?.view?.removeGestureRecognizer(self.panGesture)
            if self.gk_translationScale {
                interactivePopGestureRecognizer?.delegate = nil
                interactivePopGestureRecognizer?.isEnabled = false
                
                if !(interactivePopGestureRecognizer?.view?.gestureRecognizers?.contains(self.screenPanGesture))! {
                    interactivePopGestureRecognizer?.view?.addGestureRecognizer(self.screenPanGesture)
                    self.screenPanGesture.delegate = self.popGestureDelegate
                }
            }else {
                interactivePopGestureRecognizer?.delaysTouchesBegan = true
                interactivePopGestureRecognizer?.delegate  = self.popGestureDelegate
                interactivePopGestureRecognizer?.isEnabled = !isRootVC
            }
        }else {
            interactivePopGestureRecognizer?.delegate  = nil
            interactivePopGestureRecognizer?.isEnabled = false
            interactivePopGestureRecognizer?.view?.removeGestureRecognizer(self.screenPanGesture)
            
            if !isRootVC && !(interactivePopGestureRecognizer?.view?.gestureRecognizers?.contains(self.panGesture))! {
                interactivePopGestureRecognizer?.view?.addGestureRecognizer(self.panGesture)
                self.panGesture.delegate = self.popGestureDelegate
            }
            if self.gk_translationScale || self.gk_openScrollLeftPush {
                self.panGesture.addTarget(self.navigationDelegate, action: NSSelectorFromString("panGestureAction:"))
            }else {
                self.panGesture.addTarget(self.systemTarget(), action: NSSelectorFromString("handleNavigationTransition:"))
            }
        }
    }
}


// MARK: - GKViewControllerScrollPushDelegate
extension UINavigationController: GKViewControllerScrollPushDelegate {
    func pushNext() {
        // 获取当前控制器
        let currentVC = self.visibleViewController
        
        if ((currentVC?.gk_pushDelegate) != nil) {
            currentVC?.gk_pushDelegate?.pushToNextViewController()
        }
    }
}
