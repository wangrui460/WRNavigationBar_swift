//
//  FifthViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/21.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

private let NAVBAR_COLORCHANGE_POINT:CGFloat = (-IMAGE_HEIGHT + CGFloat(kNavBarBottom * 2))
private let IMAGE_HEIGHT:CGFloat = 260
private let SCROLL_DOWN_LIMIT:CGFloat = 100
private let LIMIT_OFFSET_Y:CGFloat = -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

class FifthViewController: UIViewController
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
        imgView.image = self.imageScaledToSize(image: UIImage(named: "image3")!, newSize: CGSize(width: kScreenWidth, height: IMAGE_HEIGHT+SCROLL_DOWN_LIMIT))
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "qq空间"
        view.backgroundColor = UIColor.red
        tableView.addSubview(imageView)
        view.addSubview(tableView)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.wr_setBackgroundColor(color: .clear)
    }
}


// MARK: - viewWillAppear .. ScrollViewDidScroll
extension FifthViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.delegate = self
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.wr_setBackgroundColor(color: .clear)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        tableView.delegate = nil
        navigationController?.navigationBar.wr_clear()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navigationController?.navigationBar.wr_setBackgroundColor(color: MainNavBarColor.withAlphaComponent(alpha))
        }
        else
        {
            navigationController?.navigationBar.wr_setBackgroundColor(color: .clear)
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
    
//    // private
//    private func changeNavBarAnimateWithIsClear(isClear:Bool)
//    {
//        UIView.animate(withDuration: 0.8, animations: { [weak self] in
//            if (isClear == true) {
//                self?.navigationController?.navigationBar.wr_setBackgroundColor(color: .clear)
//            }
//            else {
//                self?.navigationController?.navigationBar.wr_setBackgroundColor(color: MainNavBarColor)
//            }
//        })
//    }
    
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


extension FifthViewController: UITableViewDelegate,UITableViewDataSource
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
        vc.view.backgroundColor = UIColor.red
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}
