//
//  GKDemo007ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKDemo007ViewController: GKNavigationBarViewController {

    lazy var images: [UIImage] = {
        var images = [UIImage]()
        for i in 0..<7 {
            let imageName = "00\(i + 1)"
            images.append(UIImage(named: imageName)!)
        }
        
        return images
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: self.view.bounds)
        scroll.isPagingEnabled = true
        scroll.backgroundColor = UIColor.red
        
        let scrollW = scroll.width
        let scrollH = scroll.height
        
        for i in 0..<self.images.count {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: (CGFloat(i) * scrollW), y: 0, width: scrollW, height: scrollH)
            imageView.image = self.images[i]
            scroll.addSubview(imageView)
        }
        
        scroll.contentSize = CGSize(width: CGFloat(self.images.count) * scrollW, height: 0)
        
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.gk_navigationBar.isHidden = true
        
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(scrollView)
    }
}
