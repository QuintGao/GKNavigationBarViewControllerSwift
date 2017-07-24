//
//  GKPopTransitionAnimation.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKPopTransitionAnimation: NSObject {
    fileprivate var scale: Bool = false
    fileprivate var shadowView: UIView?
    
    class func transitionWithScale(scale: Bool) -> GKPopTransitionAnimation {
        return GKPopTransitionAnimation.init(scale: scale)
    }
    
    convenience init(scale: Bool) {
        self.init()
        
        self.scale = scale
    }
}

extension GKPopTransitionAnimation: UIViewControllerAnimatedTransitioning {
    // 转场动画时间
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
        
        containerView.insertSubview((toVC?.view)!, belowSubview: (fromVC?.view)!)
        
        if self.scale {
            // 初始化阴影图层
            self.shadowView = UIView(frame: CGRect(x: 0, y: 0, width: GKScreenW, height: GKScreenH))
            self.shadowView?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toVC?.view.addSubview(self.shadowView!)
            
            toVC?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.97)
        }else {
            fromVC?.view.frame = CGRect(x: -(0.3 * GKScreenW), y: 0, width: GKScreenW, height: GKScreenH)
        }
        // 添加阴影
        fromVC?.view.layer.shadowColor   = UIColor.black.cgColor
        fromVC?.view.layer.shadowOpacity = 0.5
        fromVC?.view.layer.shadowRadius  = 8
        
        // 执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            self.shadowView?.backgroundColor = UIColor.black.withAlphaComponent(0)
            fromVC?.view.frame = CGRect(x: GKScreenW, y: 0, width: GKScreenW, height: GKScreenH)
            toVC?.view.transform = CGAffineTransform.identity
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.shadowView?.removeFromSuperview()
        }
    }
}
