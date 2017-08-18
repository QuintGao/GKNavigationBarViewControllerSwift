//
//  UIScrollView+GKExtension.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

extension UIScrollView: UIGestureRecognizerDelegate {
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if panBack(gestureRecognizer: gestureRecognizer) {
            return false
        }
        
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if panBack(gestureRecognizer: gestureRecognizer) {
            return true
        }
        
        return false
    }
    
    fileprivate func panBack(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGestureRecognizer {
            let point = self.panGestureRecognizer.translation(in: self)
            
            let state = gestureRecognizer.state
            
            // 设置手势滑动的位置距离屏幕左边的距离
            let locationDistance = UIScreen.main.bounds.size.width
            
            if state == .began || state == .possible {
                let location = gestureRecognizer.location(in: self)
                if point.x > 0 && location.x < locationDistance && self.contentOffset.x <= 0 {
                    return true
                }
            }
        }
        
        return false
    }
}
