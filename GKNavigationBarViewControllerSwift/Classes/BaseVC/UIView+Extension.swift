//
//  UIView+Extension.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var f = self.frame
            f.origin.x = newValue
            self.frame = f
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var f = self.frame
            f.origin.y = newValue
            self.frame = f
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var f = self.frame
            f.size.width = newValue
            self.frame = f
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var f = self.frame
            f.size.height = newValue
            self.frame = f
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var f = self.frame
            f.origin.x = newValue - f.size.width
            self.frame = f
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var f = self.frame
            f.origin.y = newValue - f.size.height
            self.frame = f
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var c = self.center
            c.x = newValue
            self.center = c
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var c = self.center
            c.y = newValue
            self.center = c
        }
    }
}