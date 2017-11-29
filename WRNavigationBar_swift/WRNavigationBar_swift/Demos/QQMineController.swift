//
//  FirstViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit

private let IMAGE_HEIGHT:CGFloat = 280
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom)

class QQMineController: UIViewController
{    
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.backgroundColor = UIColor.clear
        table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var bottomImgView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "bottomImage"))
        imgView.frame.size = CGSize(width: kScreenWidth, height: kScreenHeight)
        return imgView
    }()
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "wangrui460"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image4"))
        imgView.frame.size = CGSize(width: 90, height: 90)
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 2
        imgView.layer.cornerRadius = 45
        imgView.layer.masksToBounds = true
        return imgView
    }()
    lazy var topView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: IMAGE_HEIGHT))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: nil)
        view.backgroundColor = UIColor.red
        view.addSubview(bottomImgView)
        view.addSubview(tableView)
        topView.addSubview(imageView)
        imageView.center = CGPoint(x: topView.center.x, y: topView.center.y - 20)
        topView.addSubview(nameLabel)
        nameLabel.frame = CGRect(x: 0, y: imageView.frame.size.height+imageView.frame.origin.y+10, width: kScreenWidth, height: 25)
        tableView.tableHeaderView = topView
        
        // 设置导航栏颜色
        navBarBarTintColor = MainNavBarColor
        
        // 设置初始导航栏透明度
        navBarBackgroundAlpha = 0
        
        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white
    }
    
    deinit {
        tableView.delegate = nil
        print("QQMineVC deinit")
    }
}


// MARK: - 滑动改变导航栏透明度
extension QQMineController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            changeNavBarAnimateWithIsClear(isClear: false)
            title = "wangrui460"
        }
        else
        {
            changeNavBarAnimateWithIsClear(isClear: true)
            title = ""
        }
    }
    
    // private
    private func changeNavBarAnimateWithIsClear(isClear:Bool)
    {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if let weakSelf = self
            {
                if (isClear == true) {
                    weakSelf.navBarBackgroundAlpha = 0
                }
                else {
                    weakSelf.navBarBackgroundAlpha = 1.0
                }
            }
        })
    }
}


extension QQMineController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cell.textLabel?.textColor = UIColor.white
        cell.accessoryType = .disclosureIndicator
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
