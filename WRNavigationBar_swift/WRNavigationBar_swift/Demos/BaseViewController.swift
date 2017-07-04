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
        // 自定义导航栏必须设置这个属性!!!!!!
        customNavBar = navBar
        
        view.addSubview(navBar)
        navBar.items = [navItem]
        
        // 设置自定义导航栏背景图片
        navBarBackgroundImage = UIImage(named: "millcolorGrad")

        // 设置自定义导航栏默认背景颜色
        // navBarBarTintColor = MainNavBarColor
        
        // 设置自定义导航栏标题颜色
        navBarTitleColor = UIColor.white

        // 设置自定义导航栏左右按钮字体颜色
        navBarTintColor = UIColor.white
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "<<", style: .plain, target: self, action: #selector(back))
    }
    
    @objc fileprivate func back()
    {
        _ = navigationController?.popViewController(animated: true)
    }
}
