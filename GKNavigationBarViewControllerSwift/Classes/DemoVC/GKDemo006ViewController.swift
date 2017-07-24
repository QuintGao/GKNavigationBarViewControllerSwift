//
//  GKDemo006ViewController.swift
//  GKNavigationBarViewController_Swift
//
//  Created by QuintGao on 2017/7/19.
//  Copyright © 2017年 高坤. All rights reserved.
//

import UIKit

class GKDemo006ViewController: GKNavigationBarViewController {

    
    lazy var tableView: UITableView = {
        
        let table = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64), style: .plain)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    var rowCount: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "UITableView"
        self.gk_navBarTintColor = UIColor.orange
        self.gk_navRightBarButtonItem = self.editButtonItem
        
        // 禁止滑动push，防止与UITableView cell 的滑动删除冲突
        self.navigationController?.gk_openScrollLeftPush = false
        
        view.addSubview(tableView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 开启滑动push
        self.navigationController?.gk_openScrollLeftPush = true
    }

    
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension GKDemo006ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "这是第\(indexPath.row + 1)行"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            rowCount -= 1
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}







