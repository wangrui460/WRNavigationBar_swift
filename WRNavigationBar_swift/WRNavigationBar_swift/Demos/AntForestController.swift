//
//  FourthViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/21.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

private let NAVBAR_COLORCHANGE_POINT:CGFloat = -480
private let IMAGE_HEIGHT:CGFloat = 480
private let SCROLL_DOWN_LIMIT:CGFloat = 0
private let LIMIT_OFFSET_Y:CGFloat = -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

class AntForestController: UIViewController
{
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-CGFloat(kNavBarBottom), 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: -IMAGE_HEIGHT, width: kScreenWidth, height: IMAGE_HEIGHT))
            imgView.contentMode = UIViewContentMode.scaleAspectFill
            imgView.clipsToBounds = true
        imgView.image = UIImage(named: "mysl")
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "蚂蚁森林"
        view.backgroundColor = UIColor.red
        tableView.addSubview(imageView)
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "··· ", style: .done, target: nil, action: nil)
        
        
        navBarBarTintColor = .white
        navBarBackgroundAlpha = 0
    }
    
    deinit {
        tableView.delegate = nil
        print("FourthVC deinit")
    }
}

// MARK: - viewWillAppear .. ScrollViewDidScroll
extension AntForestController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
            if (alpha > 0.5) {
                navBarTintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
                navBarTitleColor = .black
                statusBarStyle = .default
            } else {
                navBarTintColor = .white
                navBarTitleColor = .white
                statusBarStyle = .lightContent
            }
        }
        else
        {
            navBarBackgroundAlpha = 0
            navBarTintColor = .white
            navBarTitleColor = .white
            statusBarStyle = .lightContent
        }
        
        
        
        
        // 限制下拉距离
        if (offsetY < LIMIT_OFFSET_Y) {
            scrollView.contentOffset = CGPoint.init(x: 0, y: LIMIT_OFFSET_Y)
        }
        
        // 改变图片框的大小 (上滑的时候不改变)
        // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
        let newOffsetY = scrollView.contentOffset.y
        if (newOffsetY < -IMAGE_HEIGHT)
        {
            imageView.frame = CGRect(x: 0, y: newOffsetY, width: kScreenWidth, height: -newOffsetY)
        }
    }
}


extension AntForestController: UITableViewDelegate,UITableViewDataSource
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
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}
