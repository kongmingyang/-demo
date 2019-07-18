//
//  CustomerResouceController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/16.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit


class CustomerResouceController: BaseViewController {
   
    var dataSoure : Array<Any>!
    
    var tableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.navigationItem.title = "客户资源"
        let searchBarView = self.setupSearchBarView()
        self.view.addSubview(searchBarView)
        
        self.tableView = UITableView.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
        self.tableView .register(UINib.init(nibName: remindCell, bundle: nil), forCellReuseIdentifier: remindCell)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 130
        
        
        self.view.addSubview(self.tableView)
        searchBarView.whc_Left(0).whc_Right(0).whc_Top(1).whc_Height(44)
        self.tableView.whc_Left(0).whc_Top(0, toView: searchBarView).whc_Bottom(0).whc_Right(0)
        self.dataSoure = [1,2,3]
    }
    
    func setupSearchBarView() -> UIView {
        
        let  searchBarView = UIView.init()
        searchBarView.backgroundColor = UIColor.white
        
        let searchBar = QMUISearchBar.init()
        searchBar.backgroundImage = UIImage.qmui_image(with: UIColor.qmui_color(withHexString: "#F5F5F5"))
        searchBar.placeholder = "搜索客户姓名、联系电话"
        searchBar.layer.cornerRadius = 4
        searchBar.layer.masksToBounds = true
        searchBar.barStyle = .default

        let searchField:UITextField = searchBar.value(forKey: "_searchField") as! UITextField
         searchField.backgroundColor = UIColor.qmui_color(withHexString: "#F5F5F5")
        searchField.font = UIFont.systemFont(ofSize: 14)
        searchBarView.addSubview(searchBar)
        searchBar.whc_Left(15).whc_Right(15).whc_Height(34).whc_CenterY(0)
    
        
        return searchBarView
        
    }

}
extension CustomerResouceController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSoure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: remindCell, for: indexPath)
        return cell
    }
    
    
}
