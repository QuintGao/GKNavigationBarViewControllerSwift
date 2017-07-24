//
//  Bundle+Extension.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

extension Bundle {
    // 计算型属性类似于函数，没有参数，有返回值
    
    // 命名空间，代表项目的名称
    var nameSpace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
