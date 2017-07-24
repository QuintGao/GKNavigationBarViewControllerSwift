//
//  GKDemoBaseViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKDemoBaseViewController: GKNavigationBarViewController {

    lazy var label1: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "侧滑返回手势：开"
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: 84, width: label.width, height: label.height)
        
        return label
    }()
    
    lazy var switch1: UISwitch = { [unowned self] in
        let switch1 = UISwitch()
        switch1.x       = self.label1.right + 50
        switch1.centerY = self.label1.centerY
        switch1.isOn    = !self.gk_interactivePopDisabled
        switch1.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
        
        return switch1
    }()
    
    lazy var label2: UILabel = { [unowned self] in
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "全屏返回手势：开"
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: self.label1.bottom + 30, width: label.width, height: label.height)
        
        return label
    }()
    
    lazy var switch2: UISwitch = { [unowned self] in
        let switch2 = UISwitch()
        switch2.x = self.label2.right + 50
        switch2.centerY = self.label2.centerY
        switch2.isOn = !self.gk_fullScreenPopDisabled
        switch2.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
        
        return switch2
    }()
    
    lazy var label3: UILabel = { [unowned self] in
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = String(format: "全屏手势区域：%f", self.view.width)
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: self.label2.bottom + 30, width: label.width, height: label.height)
        
        return label
    }()
    
    lazy var slider: UISlider = { [unowned self] in
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = Float(self.view.width)
        slider.value = Float(self.view.width)
        slider.x = 20
        slider.y = self.label3.bottom + 20
        slider.width = self.view.width - 40
        slider.addTarget(self, action: #selector(sliderAction(slider:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var areaView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect(x: 0, y: self.slider.bottom + 20, width: CGFloat(self.slider.value), height: 40)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label1)
        view.addSubview(switch1)
        view.addSubview(label2)
        view.addSubview(switch2)
        view.addSubview(label3)
        view.addSubview(slider)
        view.addSubview(areaView)
    }
}

extension GKDemoBaseViewController {
    // MARK: - UserAction
    
    @objc fileprivate func switchAction(sender: UISwitch) {
        if sender == self.switch1 {
            gk_interactivePopDisabled = !gk_interactivePopDisabled
            self.label1.text = String(format: "侧滑返回手势：%@", gk_interactivePopDisabled ? "关" : "开")
            self.label1.sizeToFit()
        }else {
            gk_fullScreenPopDisabled = !gk_fullScreenPopDisabled
            
            self.label2.text = String(format: "全屏返回手势：%@", gk_fullScreenPopDisabled ? "关" : "开")
            self.label2.sizeToFit()
        }
    }
    
    @objc fileprivate func sliderAction(slider: UISlider) {
        gk_popMaxAllowedDistanceToLeftEdge = CGFloat(slider.value)
        
        self.label3.text = String(format: "全屏手势区域：%f", slider.value)
        self.label3.sizeToFit()
        
        self.areaView.width = slider.value == 0 ? self.view.width : CGFloat(slider.value);
    }
}
