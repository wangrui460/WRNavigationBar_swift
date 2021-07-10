//
//  ImageNavController .swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit

private let IMAGE_HEIGHT:CGFloat = 250
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom * 2)

class MillcolorGradController: BaseViewController
{    
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var topView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image8"))
        imgView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: IMAGE_HEIGHT)
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navBar.title = "奥黛丽·赫本"
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        tableView.tableHeaderView = topView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        view.insertSubview(navBar, aboveSubview: tableView)
        
        // 设置初始导航栏透明度
        navBar.wr_setBackgroundAlpha(alpha: 0)
        
        // 设置导航栏按钮和标题颜色
        navBar.wr_setTintColor(color: .white)
        
        // 设置状态栏style
        statusBarStyle = .lightContent
    }
    
    deinit {
        tableView.delegate = nil
        print("FirstVC deinit")
    }
}


// MARK: - 滑动改变导航栏透明度、标题颜色、左右按钮颜色、状态栏颜色
extension MillcolorGradController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBar.wr_setBackgroundAlpha(alpha: alpha)
        }
        else
        {
            navBar.wr_setBackgroundAlpha(alpha: 0)
        }
    }
}


extension MillcolorGradController:UITableViewDelegate,UITableViewDataSource
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
        let vc:BaseViewController = BaseViewController()
        vc.view.backgroundColor = UIColor.red
        let str = String(format: "右滑返回查看效果 ", indexPath.row)
        vc.navBar.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}
