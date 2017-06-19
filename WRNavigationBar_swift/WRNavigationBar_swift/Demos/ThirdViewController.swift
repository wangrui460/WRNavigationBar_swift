//
//  ThirdViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/21.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit


class ThirdViewController: UIViewController
{
    fileprivate var NAVBAR_TRANSLATION_POINT:CGFloat = 0
    fileprivate var lastOffsetY:CGFloat = 0
    
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image2"))
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "WR"
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        tableView.tableHeaderView = imageView
    }
    
    deinit {
        tableView.delegate = nil
        print("ThirdVC deinit")
    }
}


// MARK: - viewWillAppear .. ScrollViewDidScroll
extension ThirdViewController
{    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        tableView.delegate = self;
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        tableView.delegate = nil
        navigationController?.navigationBar.wr_setTranslationY(translationY: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        stopScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if decelerate == false {
            stopScroll(scrollView)
        }
    }
    
    func stopScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        // 向上滑动的距离
        let scrollUpHeight = offsetY - NAVBAR_TRANSLATION_POINT
        if (scrollUpHeight >= 22)
        {   // 超过导航栏高度的一半，只显示状态栏
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                if let weakSelf = self {
                    weakSelf.setNavigationBarTransform(scrollUpHeight: 44)
                }
            })
            print("point:\(NAVBAR_TRANSLATION_POINT)")
        }
        else
        {   // 没有超过导航栏高度的一半，导航栏全部显示
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                if let weakSelf = self {
                    weakSelf.setNavigationBarTransform(scrollUpHeight: 0)
                }
            })
            print("point:\(NAVBAR_TRANSLATION_POINT)")
        }
        NAVBAR_TRANSLATION_POINT = offsetY
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        // 向上滑动的距离
        let isScrollup = (offsetY - lastOffsetY) > 0 ? true : false
        let scrollUpHeight = (offsetY - NAVBAR_TRANSLATION_POINT) > 44 ? 44 : (offsetY - NAVBAR_TRANSLATION_POINT)
        let curTransformY = navigationController?.navigationBar.wr_getTranslationY()
        
        
        if isScrollup == true
        {   // 上滑
            if curTransformY == -44 {
                return
            }
            else
            {
                if offsetY > 0 {
                    setNavigationBarTransform(scrollUpHeight: scrollUpHeight)
                }
            }
        }
        else
        {   // 下滑
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                if let weakSelf = self {
                    weakSelf.setNavigationBarTransform(scrollUpHeight: 0)
                }
            })
        }
        
        lastOffsetY = offsetY
    }

    func setNavigationBarTransform(scrollUpHeight:CGFloat)
    {
        navigationController?.navigationBar.wr_setTranslationY(translationY: -scrollUpHeight)
        // 有系统的返回按钮，所以 hasSystemBackIndicator = YES
        let curTransformY = navigationController?.navigationBar.wr_getTranslationY() ?? 0
        navigationController?.navigationBar.wr_setBarButtonItemsAlpha(alpha: 1 - (-curTransformY / 44.0), hasSystemBackIndicator: true)
    }
}


extension ThirdViewController:UITableViewDelegate,UITableViewDataSource
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
        
        // 做成这种样式，最好不要有点击事件
    }
}
