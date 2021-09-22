//
//  CustomListController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit


class CustomListController: BaseViewController
{
    lazy var tableView:UITableView = UITableView(frame: CGRect.init(x: 0, y: CGFloat(kNavBarBottom), width: kScreenWidth, height: self.view.bounds.height), style: .plain)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } 
        view.insertSubview(navBar, aboveSubview: tableView)
        navBar.title = "自定义导航栏"
    }
}

// MARK: - tableView delegate / dataSource
extension CustomListController: UITableViewDelegate, UITableViewDataSource
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
            str = "主页"
        case 1:
            str = "导航栏显示图片"
        case 2:
            str = "实现导航栏渐变色的另一种方式"
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
            navigationController?.pushViewController(CustomNavBarController(), animated: true)
        case 1:
            navigationController?.pushViewController(ImageNavController(), animated: true)
        case 2:
            navigationController?.pushViewController(MillcolorGradController(), animated: true)
        default:
           break
        }
    }
}




