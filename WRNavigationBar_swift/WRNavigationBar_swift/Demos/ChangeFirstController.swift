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

class ChangeFirstController: UIViewController
{    
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image1"))
        imgView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: IMAGE_HEIGHT)
        return imgView
    }()
    fileprivate var isStatusBarLight = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "熊猫美妆"
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        tableView.tableHeaderView = imageView
        navBarBarTintColor = .clear
        navBarTintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isStatusBarLight {
            return .lightContent
        } else {
            return .default
        }
    }
}


// MARK: - ScrollViewDidScroll
extension ChangeFirstController
{
//    func scrollViewDidScroll(_ scrollView: UIScrollView)
//    {
//        let offsetY = scrollView.contentOffset.y
//        if (offsetY > NAVBAR_COLORCHANGE_POINT)
//        {
//            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
//            navBarBarTintColor = MainNavBarColor.withAlphaComponent(alpha)
//            isStatusBarLight = false
//        }
//        else
//        {
//            navBarBarTintColor = UIColor.clear
//            isStatusBarLight = true
//        }
//        setNeedsStatusBarAppearanceUpdate()
//    }
}


extension ChangeFirstController:UITableViewDelegate,UITableViewDataSource
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
        let vc:UIViewController = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.navBarBarTintColor = .darkGray
        vc.navBarTintColor = .orange
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "root", style: .plain, target: self, action: #selector(popToRoot))
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popToRoot()
    {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
