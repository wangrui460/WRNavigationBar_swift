//
//  CustomListController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//

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
        view.insertSubview(navBar, aboveSubview: tableView)
        navItem.title = "自定义导航栏"
        
        navBarBarTintColor = UIColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
        navBarTitleColor = .black
        statusBarStyle = .default
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
            str = "主页";
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
        default:
           break
        }
    }
}




