//
//  DemoListController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

let kNavBarBottom = 64

class DemoListController: UIViewController
{
    lazy var tableView:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "案例"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.init(red: 254/255.0, green: 128/255.0, blue: 162/255.0, alpha: 1.0)
        
        navBarBarTintColor = .white
        navBarEffectAlpha = 1.0
        navBarTintColor = .black
    }
}

// MARK: - tableView delegate / dataSource
extension DemoListController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.init(red: 255/255.0, green: 130/255.0, blue: 171/255.0, alpha: 1.0)
        var str:String? = nil
        switch indexPath.row {
        case 0:
            str = "主页";
        case 1:
            str = "超过临界点移动导航栏";
        case 2:
            str = "超过临界点多少，移动导航栏多少(不会超过44)";
        case 3:
            str = "类似qq应用空间效果";
        case 4:
            str = "类似QQ空间效果";
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
            navigationController?.pushViewController(FirstViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(SecondViewController(), animated: true)
        case 2:
            navigationController?.pushViewController(ThirdViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(FourthViewController(), animated: true)
        case 4:
            navigationController?.pushViewController(FifthViewController(), animated: true)
        default:
           break
        }
    }
}




