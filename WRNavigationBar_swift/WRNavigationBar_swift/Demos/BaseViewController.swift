//
//  BaseViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/5/16.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit

class BaseViewController: UIViewController
{
    lazy var navBar = WRCustomNavigationBar.CustomNavigationBar()
    
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
        
        // 设置自定义导航栏背景图片
        navBar.barBackgroundImage = UIImage(named: "millcolorGrad")

        // 设置自定义导航栏背景颜色
        // navBar.backgroundColor = MainNavBarColor
        
        // 设置自定义导航栏标题颜色
        navBar.titleLabelColor = .white

        // 设置自定义导航栏左右按钮字体颜色
        navBar.wr_setTintColor(color: .white)
        
        if self.navigationController?.children.count != 1 {
            navBar.wr_setLeftButton(title: "<<", titleColor: UIColor.white)
        }
    }
    
    @objc fileprivate func back()
    {
        _ = navigationController?.popViewController(animated: true)
    }
}
