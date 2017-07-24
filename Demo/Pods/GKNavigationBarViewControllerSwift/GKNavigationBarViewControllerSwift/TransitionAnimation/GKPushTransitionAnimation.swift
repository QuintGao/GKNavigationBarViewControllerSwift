//
//  GKPushTransitionAnimation.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKPushTransitionAnimation: NSObject {
    fileprivate var scale: Bool = false
    fileprivate var shadowView: UIView?
    
    class func transitionWithScale(scale: Bool) -> GKPushTransitionAnimation {
        return GKPushTransitionAnimation.init(scale: scale)
    }
    
    convenience init(scale: Bool) {
        self.init()
        
        self.scale = scale
    }
}

extension GKPushTransitionAnimation: UIViewControllerAnimatedTransitioning {
    // 转场动画的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(UINavigationControllerHideShowBarDuration)
    }
    
    // 转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 获取转场容器
        let containerView = transitionContext.containerView
        
        // 获取转场前后的控制器
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC   = transitionContext.viewController(forKey: .to)
        
        containerView.insertSubview((toVC?.view)!, aboveSubview:(fromVC?.view)!)
        
        // 设置转场前的frame
        toVC?.view.frame = CGRect(x: GKScreenW, y: 0, width: GKScreenW, height: GKScreenH)
        
        if self.scale {
            // 初始化阴影并添加
            self.shadowView = UIView(frame: CGRect(x: 0, y: 0, width: GKScreenW, height: GKScreenH))
            self.shadowView?.backgroundColor = UIColor.black.withAlphaComponent(0)
            fromVC?.view.addSubview(self.shadowView!)
        }
        
        toVC?.view.layer.shadowColor   = UIColor.black.cgColor
        toVC?.view.layer.shadowOpacity = 0.6
        toVC?.view.layer.shadowRadius  = 8
        
        // 执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            self.shadowView?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            if self.scale {
                fromVC?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.97)
            }else {
                fromVC?.view.frame = CGRect(x: -(0.3 * GKScreenW), y: 0, width: GKScreenW, height: GKScreenH)
            }
            toVC?.view.frame = CGRect(x: 0, y: 0, width: GKScreenW, height: GKScreenH)
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.shadowView?.removeFromSuperview()
        }
    }
}



















