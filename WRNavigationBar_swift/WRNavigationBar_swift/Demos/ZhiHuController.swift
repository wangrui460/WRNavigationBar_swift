//
//  ZhiHuController.swift
//  ZhihuDaily-Swift3.0
//
//  Created by wangrui on 2017/5/5.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar_swift

import UIKit

private let NAVBAR_COLORCHANGE_POINT:CGFloat = -80
private let IMAGE_HEIGHT:CGFloat = 240
private let SCROLL_DOWN_LIMIT:CGFloat = 100
private let LIMIT_OFFSET_Y:CGFloat = -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

class ZhiHuController: UIViewController
{
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: Int(kScreenWidth), height: Int(self.view.bounds.height)), style: .plain)
        table.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-CGFloat(kNavBarBottom), 0, 0, 0);
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var cycleScrollView:WRCycleScrollView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: CGFloat(kScreenWidth), height: IMAGE_HEIGHT)
        let cycleView = WRCycleScrollView(frame: frame, type: .LOCAL, imgs: nil, descs: nil)
        return cycleView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "知乎日报"
        view.backgroundColor = UIColor.white
        let localImages = ["localImg6","localImg7","localImg8","localImg9","localImg10"]
        let descs = ["韩国防部回应停止部署萨德:遵照最高统帅指导方针",
                     "勒索病毒攻击再次爆发 国内校园网大面积感染",
                     "Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
                     "《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
                     "阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"]
        cycleScrollView.localImgArray = localImages
        cycleScrollView.descTextArray = descs
        tableView.addSubview(cycleScrollView)
        view.addSubview(tableView)
        
        navBarBarTintColor = MainNavBarColor
        navBarBackgroundAlpha = 0
        navBarTintColor = .white
    }
    
    deinit {
        tableView.delegate = nil
        print("ZhiHuVC deinit")
    }
}

// MARK: - ScrollViewDidScroll
extension ZhiHuController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
        }
        else
        {
            navBarBackgroundAlpha = 0
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
            cycleScrollView.frame = CGRect(x: 0, y: newOffsetY, width: CGFloat(kScreenWidth), height: -newOffsetY)
        }
    }
    
    // private
    fileprivate func imageScaledToSize(image:UIImage, newSize:CGSize) -> UIImage
    {
        UIGraphicsBeginImageContext(CGSize(width: newSize.width * 2.0, height: newSize.height * 2.0))
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width * 2.0, height: newSize.height * 2.0))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension ZhiHuController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        let str = String(format: "知乎日报 %zd", indexPath.row)
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:UIViewController = UIViewController()
        vc.view.backgroundColor = UIColor.red
        let str = String(format: "知乎日报 %zd", indexPath.row)
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}



