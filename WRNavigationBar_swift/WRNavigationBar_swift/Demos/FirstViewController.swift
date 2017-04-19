//
//  FirstViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
    let IMAGE_HEIGHT:CGFloat = 260
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        return table
    }()
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image1"))
        imgView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.IMAGE_HEIGHT)
        return imgView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "熊猫美妆"
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = imageView
        navigationController?.navigationBar.wr_setBackgroundColor(color: .clear)
    }
}


// MARK: - viewWillAppear .. ScrollViewDidScroll
extension FirstViewController
{
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.wr_clear()
    }
}

extension FirstViewController:UITableViewDelegate,UITableViewDataSource
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
