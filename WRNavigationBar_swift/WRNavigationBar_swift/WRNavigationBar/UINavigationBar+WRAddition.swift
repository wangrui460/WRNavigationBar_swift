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


extension DispatchQueue {
    
    private static var onceTracker = [String]()
    
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if onceTracker.contains(token) {
            return
        }
        
        onceTracker.append(token)
        block()
    }
}

extension UINavigationController {
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    private static let onceToken = UUID().uuidString
    
    open override class func initialize() {
        guard self == UINavigationController.self else { return }
        
        DispatchQueue.once(token: onceToken) {
            let needSwizzleSelectorArr = [
                NSSelectorFromString("_updateInteractiveTransition:"),
                #selector(popToViewController),
                #selector(popToRootViewController)
            ]
            
            for selector in needSwizzleSelectorArr {
                
                let str = ("wr_" + selector.description).replacingOccurrences(of: "__", with: "_")
                // popToRootViewController: Animated: wr_popToRootViewController: Animated:
                // popToRootViewController: Animated: wr_popToRootViewController: Animated:
                // _updateInteractiveTransition:      wr_updateInteractiveTransition:
                
                let originalMethod = class_getInstanceMethod(self, selector)
                let swizzledMethod = class_getInstanceMethod(self, Selector(str))
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    func wr_updateInteractiveTransition(_ percentComplete: CGFloat)
    {
        guard let topViewController = topViewController,
              let coordinator       = topViewController.transitionCoordinator
            else {
                // call system _updateInteractiveTransition
                wr_updateInteractiveTransition(percentComplete)
            return
        }
        
        let fromViewController = coordinator.viewController(forKey: .from)
        let toViewController = coordinator.viewController(forKey: .to)
        
        // change navBarBgColor
        let fromBgColor = fromViewController?.navBarBgColor ?? .defaultNavBarBgColor
        let toBgColor = toViewController?.navBarBgColor ?? .defaultNavBarBgColor
        let newBgColor = averageColor(fromColor: fromBgColor, toColor: toBgColor, percent: percentComplete)
        setNeedsNavigationBackground(color: newBgColor)
        
        // change navBarTintColor
        let fromTintColor = fromViewController?.navBarTintColor ?? .blue
        let toTintColor = toViewController?.navBarTintColor ?? .blue
        let newTintColor = averageColor(fromColor: fromTintColor, toColor: toTintColor, percent: percentComplete)
        navigationBar.tintColor = newTintColor
        
        // call system _updateInteractiveTransition
        wr_updateInteractiveTransition(percentComplete)
    }
    
    // Calculate the middle Color with translation percent
    private func averageColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        let nowRed = fromRed + (toRed - fromRed) * percent
        let nowGreen = fromGreen + (toGreen - fromGreen) * percent
        let nowBlue = fromBlue + (toBlue - fromBlue) * percent
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent
        
        return UIColor(red: nowRed, green: nowGreen, blue: nowBlue, alpha: nowAlpha)
    }
    
    func wr_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(color: viewController.navBarBgColor)
        navigationBar.tintColor = viewController.navBarTintColor
        return wr_popToViewController(viewController, animated: animated)
    }
    
    func wr_popToRootViewControllerAnimated(_ animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(color: viewControllers.first?.navBarBgColor ?? .defaultNavBarBgColor)
        navigationBar.tintColor = viewControllers.first?.navBarTintColor
        return wr_popToRootViewControllerAnimated(animated)
    }
    
    fileprivate func setNeedsNavigationBackground(color: UIColor) {
        navigationBar.wr_setBackgroundColor(color: color)
    }
}


extension UINavigationController: UINavigationBarDelegate {
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if let topVC = topViewController,
           let coor = topVC.transitionCoordinator, coor.initiallyInteractive {
            //添加对返回交互的监控
            if #available(iOS 10.0, *) {
                coor.notifyWhenInteractionChanges({ (context) in
                    self.dealInteractionChanges(context)
                })
            } else {
                coor.notifyWhenInteractionEnds({ (context) in
                    self.dealInteractionChanges(context)
                })
            }
            return true
        }
        
        let itemCount = navigationBar.items?.count ?? 0
        let n = viewControllers.count >= itemCount ? 2 : 1
        let popToVC = viewControllers[viewControllers.count - n]
        
        popToViewController(popToVC, animated: true)
        return true
    }
    
    
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
            self.setNeedsNavigationBackground(color: self.topViewController?.navBarBgColor ?? UIColor.defaultNavBarBgColor)
        return true
    }
    
    //处理返回手势中断的情况
    private func dealInteractionChanges(_ context: UIViewControllerTransitionCoordinatorContext) {
        let animations: (UITransitionContextViewControllerKey) -> () = {
            let curColor = context.viewController(forKey: $0)?.navBarBgColor ?? UIColor.defaultNavBarBgColor
            self.setNeedsNavigationBackground(color: curColor)
        }
        
        //自动取消了返回手势
        if context.isCancelled {
            let cancelDuration: TimeInterval = context.transitionDuration * Double(context.percentComplete)
            UIView.animate(withDuration: cancelDuration) {
                animations(.from)
            }
        } else {
            //自动完成了返回手势
            let finishDuration: TimeInterval = context.transitionDuration * Double(1 - context.percentComplete)
            UIView.animate(withDuration: finishDuration) {
                animations(.to)
            }
        }
    }
}

// MARK: - 记录当前ViewController的导航栏颜色
extension UIViewController
{
    fileprivate struct AssociatedKeys {
        static var navBarBgColor: UIColor = UIColor.defaultNavBarBgColor
        static var navBarTintColor: UIColor = UIColor.defaultNavBarTintColor
    }
    
    var navBarBgColor: UIColor {
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.navBarBgColor) as? UIColor else {
                return UIColor.defaultNavBarBgColor
            }
            return color
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navBarBgColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            navigationController?.setNeedsNavigationBackground(color: newValue)
        }
    }
    
    var navBarTintColor: UIColor {
        get {
            guard let tintColor = objc_getAssociatedObject(self, &AssociatedKeys.navBarTintColor) as? UIColor else {
                return UIColor.defaultNavBarTintColor
            }
            return tintColor
            
        }
        set {
            navigationController?.navigationBar.tintColor = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.navBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIColor
{
    class var defaultNavBarBgColor: UIColor {
        return UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
    }
    class var defaultNavBarTintColor: UIColor {
        return UIColor.white
    }
}
