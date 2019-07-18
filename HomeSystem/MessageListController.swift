//
//  MessageListController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/15.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HandyJSON
import Moya
let messageCell = "MessageCell"

class MessageListController: BaseViewController {
   
    var tableView : UITableView!
    let disposed = DisposeBag()
    var dataSource : Array<Any>!
    var pageNo : Int = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationItem.title = "消息"

        self.tableView = UITableView.init()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        self.tableView.estimatedRowHeight = 150
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView .register(UINib.init(nibName: messageCell, bundle: nil), forCellReuseIdentifier: messageCell)
        //算是初始化了，不然会崩溃
       self.dataSource = []
        self.pageNo = 1
  
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.pageNo = 1
            self.dataSource.removeAll()
            self.getListDatas(page: String.init(describing: self.pageNo))
            
        })
        let footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
         self.pageNo = self.pageNo + 1
            self.getListDatas(page: String.init(describing: self.pageNo))
          
           
        })
        footer?.setTitle("", for: .noMoreData)
        footer?.setTitle("", for: .idle)
        self.tableView.mj_footer = footer;
     
        let button = UIButton.init()
        button.backgroundColor = UIColor.white
        button .setImage(UIImage.init(named: "button_delete"), for: .normal)
        button.rx.tap.subscribe(onNext: { [weak self] in
            
            let alertVC = AlertViewController.init()
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.titleItem = "确定清空消息列表？"
            alertVC.leftTitle = "取消"
            alertVC.rightTitle = "确定"
            alertVC.delegate = self
            self?.present(alertVC, animated: true, completion: nil)
            
            
     
        }).disposed(by: disposed)
        button.contentHorizontalAlignment = .center
        self.view.addSubview(button)
        self.tableView.whc_Left(0).whc_Right(0).whc_Bottom(64, false).whc_Top(0)
        button.whc_Left(0).whc_Right(0).whc_Bottom(20, false).whc_Height(44)
      self.tableView.mj_header .beginRefreshing()
        
    }
    
    
    func getListDatas(page:String) {
        let provider = MoyaProvider<LoginApi>()
        provider.request(.getRepairListDatas(type: page, page: "1", pageSize: "10")) { (result) in
            switch result {
                
            case let .success(response):
                let jsonString = try?JSONSerialization.jsonObject(with: response.data, options: .mutableContainers)
                let dic:[String:Any] = jsonString  as! [String : Any];
                let code:String = dic["code"] as!String
                let msg:String = dic["msg"] as!String
                guard code=="000000" else{
                    MBProgressHUD.hide()
                    MBProgressHUD .showError(msg)
                    return
                }
                //TODO:字典数组转模型数组
                let jsonDic:[String:Any] = dic["data"] as! [String : Any]
                let jsons = jsonDic["list"] as! [[String:Any]]
                print(jsons)
                let models = [MessageListModel].deserialize(from: jsons)
                //                print(models)
                if models!.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                //maph函数便利
                self.dataSource = models?.map({ (model)  in
                    model as Any
                })
                //遍历数组加入可变数组
//                if models!.count > 0 {
//                    for model in models! {
//                      self.dataSource.append(model as Any)
//                    }
//                }
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
                
                break
            case let .failure(error):
                
                MBProgressHUD.showError(error.errorDescription)
                
                break
                
            }
        }
    }

}

extension MessageListController:UITableViewDelegate,UITableViewDataSource,AlertViewControllerDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            self.dataSource.remove(at: indexPath.row)
//            self.tableView.reloadData()
//            print("删除")
//        }
//    }
    //可编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action1 = UITableViewRowAction.init(style: .normal, title: "确定") { (action, index) in
            self.dataSource.remove(at: index.row)
            self.tableView.reloadData()
        }
        action1.backgroundColor = UIColor.orange
        let action2 = UITableViewRowAction.init(style: .normal, title: "取消") { (action, index) in
            self.dataSource.remove(at: index.row)
            self.tableView.reloadData()
        }
        
        return [action1,action2]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: messageCell, for: indexPath) as! MessageCell
        cell.listModel = (self.dataSource[indexPath.row] as! MessageListModel)
        cell.reloadUI()
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
    }
    //MARK: AlertViewDelegate
    func didSelectedItem(tag: AlertBtnType) {
        switch tag {
        case AlertBtnType.cancle:
            
         break
        case AlertBtnType.confirm:
            self.dataSource.removeAll()
            self.tableView .reloadData()
           break
            
     
        }

    }
    
}
