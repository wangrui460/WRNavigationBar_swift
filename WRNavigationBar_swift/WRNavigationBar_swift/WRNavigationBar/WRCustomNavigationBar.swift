//
//  WRCustomNavigationBar.swift
//  WRNavigationBar_swift
//
//  Created by itwangrui on 2017/11/25.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

fileprivate let WRDefaultTitleSize = 18
fileprivate let WRDefaultTitleColor = UIColor.black
fileprivate let WRDefaultBackgroundColor = UIColor.white
fileprivate let WRScreenWidth = UIScreen.main.bounds.size.width


// MARK: - Router
extension UIViewController
{
    //  A页面 弹出 登录页面B
    //  presentedViewController:    A页面
    //  presentingViewController:   B页面
    
    func wr_toLastViewController(animated:Bool)
    {
        if self.navigationController != nil
        {
            if self.navigationController?.viewControllers.count == 1
            {
                self.dismiss(animated: animated, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: animated)
            }
        }
        else if self.presentingViewController != nil {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
//    class func wr_currentViewController() -> UIViewController
//    {
//        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
//            return self.wr_currentViewController(from: rootVC)
//        } else {
//            return UIViewController()
//        }
//    }
//
//    class func wr_currentViewController(from:UIViewController) -> UIViewController
//    {
//
//    }
}



class WRCustomNavigationBar: UIView
{
    
    

}
