//
//  GKNavigationBarConfigure.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

let GKScreenW = UIScreen.main.bounds.size.width
let GKScreenH = UIScreen.main.bounds.size.height

open class GKNavigationBarConfigure: NSObject {
    open static var shared: GKNavigationBarConfigure = GKNavigationBarConfigure()
    
    public var barTintColor: UIColor?
    public var tintColor: UIColor?
    public var titleColor: UIColor?
    public var titleFont: UIFont?
    
    // 统一配置导航栏外观，最好在AppDelegate中配置
    public func setupDefaultConfigure() {
        barTintColor = UIColor.white
        tintColor    = UIColor.black
        titleColor   = UIColor.black
        titleFont    = UIFont.boldSystemFont(ofSize: 17.0)
    }
    
    public func gk_swizzled_method(_ cls: Swift.AnyClass!, _ originalSelector: Selector!, _ swizzledSelector: Selector!) {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
        
        let isAdd = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if isAdd {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
