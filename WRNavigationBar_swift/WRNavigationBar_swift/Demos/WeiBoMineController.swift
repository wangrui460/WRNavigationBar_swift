//
//  WeiBoMineController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit

private let IMAGE_HEIGHT:CGFloat = 220
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom * 2)

class WeiBoMineController: UIViewController
{    
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var iconView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image5"))
        imgView.frame.size = CGSize(width: 80, height: 80)
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 2
        imgView.layer.cornerRadius = 40
        imgView.layer.masksToBounds = true
        return imgView
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "wangrui460"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    lazy var fansLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "关注 121  |  粉丝 17"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    lazy var detailLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "简介:丽人丽妆公司，熊猫美妆APP iOS工程师"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    lazy var topView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "wbBg"))
        imgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: IMAGE_HEIGHT)
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = ""
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        topView.addSubview(iconView)
        iconView.center = CGPoint(x: topView.center.x, y: topView.center.y - 10)
        topView.addSubview(nameLabel)
        nameLabel.frame = CGRect(x: 0, y: iconView.frame.size.height+iconView.frame.origin.y+6, width: kScreenWidth, height: 19)
        topView.addSubview(fansLabel)
        fansLabel.frame = CGRect(x: 0, y: nameLabel.frame.origin.y+19+5, width: kScreenWidth, height: 16)
        topView.addSubview(detailLabel)
        detailLabel.frame = CGRect(x: 0, y: fansLabel.frame.origin.y+16+5, width: kScreenWidth, height: 15)
        tableView.tableHeaderView = topView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "··· ", style: .done, target: nil, action: nil)
        
        // 设置导航栏颜色
        navBarBarTintColor = UIColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
        
        // 设置初始导航栏透明度
        navBarBackgroundAlpha = 0
        
        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white
        
        // 如果需要隐藏导航栏底部分割线，设置 hideShadowImage 为true
        // hideShadowImage = true
    }
    
    deinit {
        tableView.delegate = nil
        print("FirstVC deinit")
    }
}


// MARK: - 滑动改变导航栏透明度、标题颜色、左右按钮颜色、状态栏颜色
extension WeiBoMineController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
            navBarTintColor = UIColor.black.withAlphaComponent(alpha)
            navBarTitleColor = UIColor.black.withAlphaComponent(alpha)
            statusBarStyle = .default
            title = "wangrui460"
        }
        else
        {
            navBarBackgroundAlpha = 0
            navBarTintColor = .white
            navBarTitleColor = .white
            statusBarStyle = .lightContent
            title = ""
        }
    }
}


extension WeiBoMineController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
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
        let str = "WRNavigationBar"
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}
