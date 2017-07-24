//
//  GKMainViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/18.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKMainViewController: GKNavigationBarViewController {

    lazy var tableView: UITableView = { [unowned self] in
        let table = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64), style: .plain)
        table.delegate   = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return table
    }()
    
    lazy var dataSource = ["push一个变色导航栏控制器",
                           "push一个透明导航栏控制器",
                           "push一个无导航栏控制器",
                           "push一个UITabBarController",
                           "present一个UITabBarController",
                           "push一个UITableView",
                           "push一个UIScrollView",
                           "今日头条",
                           "网易云音乐",
                           "网易新闻"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "MainVC"
        
        self.gk_navBarTintColor = UIColor.red
        
        self.gk_navTitleFont = UIFont.systemFont(ofSize: 18.0)
        
        self.gk_navTitleColor = UIColor.gray
        
        self.view.addSubview(self.tableView)
        
    }

}

extension GKMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row < 7 {
            let clsName = String(format: "GKDemo00%zdViewController", indexPath.row + 1)
            
            guard let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type else {
                return
            }
            
            let vc = cls.init()
            
            if indexPath.row == 4 {
                
                self.present(vc, animated: true, completion: nil)
                
                return
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }else {
            if indexPath.row == 7 {
                let toutiaoVC = GKToutiaoViewController()
                
                // 根控制器是导航控制器，需要缩放
                let nav = UINavigationController(rootVC: toutiaoVC, translationScale: true)
                
                self.present(nav, animated: true, completion: nil)
                
                return
            }
            
            if indexPath.row == 8 {
                let wyMusicVC = GKWYMusicViewController()
                
                // 根视图控制器是UITabBarController，不需要缩放
                self.present(wyMusicVC, animated: true, completion: nil)
                
                return
            }
            
            if indexPath.row == 9 {
                let wyNewsVC = GKWYNewsViewController()
                
                // 根控制器是UITabBarController，不需要缩放
                self.present(wyNewsVC, animated: true, completion: nil)
                
                return
            }
        }
    }
}
