//
//  UINavigationBar+WRAddition.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

let kBackgroundViewKey = UnsafeRawPointer(bitPattern: "kBackgroundViewKey".hash)
let kNavBarBottom = 64

extension UINavigationBar
{
    /// 设置导航栏背景颜色
    func wr_setBackgroundColor(color:UIColor)
    {
        if (self.backgroundView() == nil)
        {
            // 设置导航栏本身全透明
            self.setBackgroundImage(UIImage(), for: .default)
            self.setBackgroundView(backgroundView: UIView(frame: CGRect(x: 0, y: 0, width: Int(bounds.width), height: kNavBarBottom)))
            // _UIBarBackground是导航栏的第一个子控件
            self.subviews.first?.insertSubview(self.backgroundView() ?? UIView(), at: 0)
            // 隐藏导航栏底部默认黑线
            self.shadowImage = UIImage()
        }
        self.backgroundView()?.backgroundColor = color
    }
    
    /// 设置导航栏所有BarButtonItem的透明度
    func wr_setBarButtonItemsAlpha(alpha:CGFloat, hasSystemBackIndicator:Bool)
    {
        for view in self.subviews
        {
            if (hasSystemBackIndicator == true)
            {
                // _UIBarBackground对应的view是系统导航栏，不需要改变其透明度
                if let _UIBarBackgroundClass = NSClassFromString("_UIBarBackground")
                {
                    if (view.isKind(of: _UIBarBackgroundClass) == false) {
                        view.alpha = alpha
                    }
                }
            }
            else
            {
                // 这里如果不做判断的话，会显示 backIndicatorImage(系统返回按钮)
                if let _UINavigationBarBackIndicatorViewClass = NSClassFromString("_UINavigationBarBackIndicatorView"),
                   let _UIBarBackgroundClass                  = NSClassFromString("_UIBarBackground")
                {
                    if (view.isKind(of: _UINavigationBarBackIndicatorViewClass) == false && view.isKind(of: _UIBarBackgroundClass) == false) {
                        view.alpha = alpha
                    }
                }
            }
        }
    }
    
    /// 设置导航栏在垂直方向上平移多少距离
    func wr_setTranslationY(translationY:CGFloat)
    {
        self.transform = CGAffineTransform.init(translationX: 0, y: translationY)
    }
    
    /// 清除在导航栏上设置的背景颜色、透明度、位移距离等属性
    func wr_clear()
    {
        // 设置导航栏不透明
        self.setBackgroundImage(nil, for: .default)
        self.backgroundView()?.removeFromSuperview()
        self.setBackgroundView(backgroundView: nil)
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    // private func
    func backgroundView() -> UIView?
    {
        return objc_getAssociatedObject(self, kBackgroundViewKey) as? UIView
    }
    
    func setBackgroundView(backgroundView:UIView?)
    {
        objc_setAssociatedObject(self, kBackgroundViewKey, backgroundView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

extension UINavigationController: UINavigationBarDelegate
{
    // 加上一个这样的分类和方法可以解决返回熊猫美妆界面时，导航栏过一段时间再透明的问题（如果觉得没必要可以去掉）
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool
    {
        if (self.viewControllers.count < (navigationBar.items?.count)!) {
            return true
        }
        
        DispatchQueue.main.async {
            self.popViewController(animated: true)
        }
        return false
    }
}
