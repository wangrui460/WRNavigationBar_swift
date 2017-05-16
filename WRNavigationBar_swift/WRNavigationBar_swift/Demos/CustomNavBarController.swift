//
//  FirstViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

private let IMAGE_HEIGHT:CGFloat = 260
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom * 2)

class CustomNavBarController: BaseViewController
{    
    lazy var tableView:UITableView = {
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height)
        let table:UITableView = UITableView(frame: frame, style: .plain)
        table.contentInset = UIEdgeInsetsMake(0, 0, CGFloat(kTabBarHeight), 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image1"))
        imgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: IMAGE_HEIGHT)
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "自定义导航栏"
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        tableView.tableHeaderView = imageView
        view.insertSubview(navBar, aboveSubview: tableView)
        navigationController?.navigationBar.barStyle = .black
        navBar.wr_setBackgroundColor(color: .clear)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "star", style: .plain, target: self, action: nil)
        navItem.title = "自定义导航栏"
    }
}


// MARK: - viewWillAppear .. ScrollViewDidScroll
extension CustomNavBarController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.delegate = self
        scrollViewDidScroll(tableView)
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 如果不取消代理的话，跳转到下一个页面后，还会调用 scrollViewDidScroll 方法
        tableView.delegate = nil
        navBar.wr_clear()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBar.wr_setBackgroundColor(color: MainNavBarColor.withAlphaComponent(alpha))
        }
        else
        {
            navBar.wr_setBackgroundColor(color: UIColor.clear)
        }
    }
}


extension CustomNavBarController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:BaseViewController = BaseViewController()
        vc.view.backgroundColor = UIColor.red
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        vc.navItem.title = str
        vc.navItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(back))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func back()
    {
        _ = navigationController?.popViewController(animated: true)
    }
}
