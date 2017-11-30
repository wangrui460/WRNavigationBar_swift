//
//  NormalListController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit

let kNavBarBottom = WRNavigationBar.navBarBottom()

class NormalListController: UIViewController
{
    lazy var tableView:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "常用"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        
        // 改变标题文字大小
        // navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 22)]
    }
}



// MARK: - tableView delegate / dataSource
extension NormalListController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        var str:String? = nil
        switch indexPath.row {
        case 0:
            str = "新浪微博个人中心"
        case 1:
            str = "类似qq应用空间效果"
        case 2:
            str = "类似QQ空间效果"
        case 3:
            str = "知乎日报"
        case 4:
            str = "QQ我的资料页"
        case 5:
            str = "蚂蚁森林"
        case 6:
            str = "连续多个界面导航栏透明"
        default:
            str = ""
        }
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(WeiBoMineController(), animated: true)
        case 1:
            navigationController?.pushViewController(QQAppController(), animated: true)
        case 2:
            navigationController?.pushViewController(QQZoneController(), animated: true)
        case 3:
            navigationController?.pushViewController(ZhiHuController(), animated: true)
        case 4:
            navigationController?.pushViewController(QQMineController(), animated: true)
        case 5:
            navigationController?.pushViewController(AntForestController(), animated: true)
        case 6:
            navigationController?.pushViewController(AllTransparent(), animated: true)
        default:
           break
        }
    }
}




