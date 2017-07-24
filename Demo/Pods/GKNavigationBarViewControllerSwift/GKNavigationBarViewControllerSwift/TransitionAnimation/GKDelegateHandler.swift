//
//  GKDelegateHandler.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

// 左滑push的代理
protocol GKViewControllerScrollPushDelegate: NSObjectProtocol {
    func pushNext()
}

// 此类用于处理UIGestureRecoginzer的代理方法
public class GKPopGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    var navigationController: UINavigationController!
    var systemTarget: Any!
    var customTarget: GKNavigationControllerDelegate!
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gesture = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        
        // 忽略跟控制器
        if self.navigationController.viewControllers.count <= 1 {
            return false
        }
        
        let topVC = self.navigationController.viewControllers.last
        // 忽略禁用手势控制器
        if (topVC?.gk_interactivePopDisabled)! {
            return false
        }
        
        // 滑动区域方向
        let transition = gesture.translation(in: gesture.view)
        let systemAction = NSSelectorFromString("handleNavigationTransition:")
        let customAction = NSSelectorFromString("panGestureAction:")
        
        if transition.x < 0 {
            if self.navigationController.gk_openScrollLeftPush {
                gesture.removeTarget(self.systemTarget, action: systemAction)
                gesture.addTarget(self.customTarget, action: customAction)
            }else {
                return false
            }
        }else {
            // 忽略超出手势区域
            let beginningLocation = gesture .location(in: gesture.view)
            let maxAllowDistance  = topVC?.gk_popMaxAllowedDistanceToLeftEdge ?? 0
            if maxAllowDistance > 0 && beginningLocation.x > maxAllowDistance {
                return false
            }else if !self.navigationController.gk_translationScale { // 非缩放，系统处理
                gesture.removeTarget(self.customTarget, action: customAction)
                gesture.addTarget(self.systemTarget, action: systemAction)
            }else {
                gesture.removeTarget(self.systemTarget, action: systemAction)
                gesture.addTarget(self.customTarget, action: customAction)
            }
        }
        
        // 忽略导航控制器正在做转场动画
        if self.navigationController.value(forKey: "_isTransitioning") as! Bool {
            return false
        }
        
        return true
    }
}

// 此类用于处理UINavigationControllerDelegate的代理方法
public class GKNavigationControllerDelegate: NSObject {
    
    var navigationController: UINavigationController!
    weak var pushDelegate: GKViewControllerScrollPushDelegate?
    
    fileprivate var isGesturePush: Bool = false
    fileprivate var pushTransition: UIPercentDrivenInteractiveTransition?
    fileprivate var popTransition: UIPercentDrivenInteractiveTransition?
    
    // MARK: - 滑动手势的处理
    @objc public func panGestureAction(_ gesture: UIPanGestureRecognizer) {
        // 进度
        var progress = gesture.translation(in: (gesture.view)!).x / (gesture.view?.bounds.size.width)!
        
        let translation = gesture.velocity(in: gesture.view)
        
        // 在手势开始时判断是push操作还是pop操作
        if gesture.state == .began {
            self.isGesturePush = translation.x < 0 ? true : false
        }
        
        // push时 progress < 0 需要做处理
        if self.isGesturePush {
            progress = -progress
        }
        
        progress = min(1.0, max(0.0, progress))
        
        if gesture.state == .began {
            if self.isGesturePush {
                if self.navigationController.gk_openScrollLeftPush && self.pushDelegate != nil {
                    self.pushTransition = UIPercentDrivenInteractiveTransition()
                    self.pushTransition?.completionCurve = .easeInOut
                    
                    self.pushDelegate?.pushNext()
                    
                    self.pushTransition?.update(0)
                }
            }else {
                self.popTransition = UIPercentDrivenInteractiveTransition()
                self.navigationController.popViewController(animated: true)
            }
        }else if gesture.state == .changed {
            if self.isGesturePush {
                if self.navigationController.gk_openScrollLeftPush {
                    self.pushTransition?.update(progress)
                }
            }else {
                self.popTransition?.update(progress)
            }
        }else if gesture.state == .ended || gesture.state == .cancelled {
            if self.isGesturePush {
                if self.navigationController.gk_openScrollLeftPush {
                    if progress > 0.5 {
                        self.pushTransition?.finish()
                    }else {
                        self.pushTransition?.cancel()
                    }
                }
            }else {
                if progress > 0.5 {
                    self.popTransition?.finish()
                }else {
                    self.popTransition?.cancel()
                }
            }
            
            self.pushTransition = nil
            self.popTransition  = nil
            self.isGesturePush  = false
        }
    }
}


// MARK: - UINavigaitonControllerDelegate

extension GKNavigationControllerDelegate: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (self.navigationController.gk_translationScale) || (self.navigationController.gk_openScrollLeftPush && (self.pushTransition != nil)) {
            if operation == .push {
                return GKPushTransitionAnimation(scale: self.navigationController.gk_translationScale)
            }else if operation == .pop {
                return GKPopTransitionAnimation(scale: self.navigationController.gk_translationScale)
            }
        }
        return nil
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if (self.navigationController.gk_translationScale) || (self.navigationController.gk_openScrollLeftPush && (self.pushTransition != nil)) {
            if animationController.isKind(of: GKPushTransitionAnimation.self) {
                return self.pushTransition
            }else if animationController.isKind(of: GKPopTransitionAnimation.self) {
                return self.popTransition
            }
        }
        return nil
    }
}

