//
//  BaseViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/5/16.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController
{
    lazy var navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 64))
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
        
    }

    fileprivate func setupNavBar()
    {
        view.addSubview(navBar)
        navBar.items = [navItem]
        // 导航条背景颜色
        navBar.barTintColor = MainNavBarColor
        // 导航条标题颜色
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        // 导航条左右按钮字体颜色
        navBar.tintColor = UIColor.white
    }
}
