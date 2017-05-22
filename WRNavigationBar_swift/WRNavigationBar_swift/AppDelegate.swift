//
//  AppDelegate.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

let MainNavBarColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kTabBarHeight = 49
let kNavBarHeight = 44

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let firstNav = BaseNavigationController.init(rootViewController: DemoListController())
        let secondNav = BaseNavigationController.init(rootViewController: SixthViewController())
        let thirdNav = BaseNavigationController.init(rootViewController: CustomNavBarController())
        secondNav.title = "没有系统返回按钮的情况"
        thirdNav.title = "自定义导航栏"
        let tabBarVC = UITabBarController.init()
        tabBarVC.viewControllers = [firstNav, secondNav, thirdNav]
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
//        setNavBarAppearence()
        return true
    }

    func setNavBarAppearence()
    {
        let navBar = UINavigationBar.appearance()
        // BarButtonItem颜色（例如返回按钮颜色）
        navBar.tintColor = UIColor.white
        // 导航栏背景颜色
        navBar.barTintColor = MainNavBarColor
        // 标题文字颜色
        navBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 21), NSForegroundColorAttributeName:UIColor.white]
    }
}

