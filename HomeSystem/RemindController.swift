//
//  RemindController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/15.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
let remindCell = "RemindCell"

class RemindController: BaseViewController {
    
    let disposeBag = DisposeBag()
     var dataSource : Array<Any>!
    var  tableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title = "跟进提醒"
        
        let topView = self.setuptopToolView()
        self.view.addSubview(topView)
        topView.whc_Left(0).whc_Right(0).whc_Top(0).whc_Height(44)
         self.dataSource = [1,2,3,4,5]
        self.tableView = UITableView.init()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView .register(UINib.init(nibName: remindCell, bundle: nil), forCellReuseIdentifier: remindCell)
         self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableView.automaticDimension
       
        self.view.addSubview(self.tableView)
        self.tableView.whc_AutoSize(left: 0, top: 44, right: 0, bottom: 0)
        
        self.tableView.mj_header = MJRefreshNormalHeader.init {
            self.tableView.mj_header.endRefreshing()
        }
        
        let footer = MJRefreshAutoNormalFooter.init {
            self.tableView.mj_footer.endRefreshing()
          self.tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        
        self.tableView.mj_footer = footer
        footer?.setTitle("", for: .noMoreData)
        footer?.setTitle("", for: .idle)
        self.tableView.mj_header.beginRefreshing()
       
    }
    
    func setuptopToolView() -> UIView {
        
        let topView = UIView.init()
        topView.backgroundColor = UIColor.white
        
        let leftBtn = UIButton.init()
        leftBtn.setTitle("今日需跟进", for:.normal)
        leftBtn.setTitleColor(sixColor, for: .normal)
        leftBtn.setTitleColor(UIColor.qmui_color(withHexString: "#rightBtn"), for: .selected)
        
        let rightBtn = UIButton.init()
        rightBtn.setTitle("逾期未跟进", for:.normal)
        rightBtn.setTitleColor(sixColor, for: .normal)
        rightBtn.setTitleColor(UIColor.qmui_color(withHexString: "#0B98FF"), for: .selected)
        
        let line = UIView.init()
        line.backgroundColor = UIColor.qmui_color(withHexString: "#0B98FF")
        
        topView.addSubview(leftBtn)
        topView.addSubview(rightBtn)
        topView.addSubview(line)
        
        leftBtn.whc_Left(0).whc_Top(0).whc_Bottom(2).whc_WidthEqual(topView, ratio: 0.5)
        rightBtn.whc_Right(0).whc_Top(0).whc_Bottom(2).whc_WidthEqual(topView, ratio: 0.5)
        line.whc_CenterX(0, toView: leftBtn).whc_Height(2).whc_Bottom(0).whc_Width(106)
        
        
        leftBtn.rx.tap.subscribe({_ in
        
        line.whc_RemoveAttrs(.centerX).whc_CenterX(0, toView: leftBtn) .whc_Height(2).whc_Bottom(0).whc_Width(106)
            self.tableView.mj_header.beginRefreshing()
        }).disposed(by: self.disposeBag)
        
        rightBtn.rx.tap.subscribe({_ in
            
            line.whc_RemoveAttrs(.centerX)
        line.whc_RemoveAttrs(.centerX).whc_CenterX(0, toView: rightBtn).whc_Height(2).whc_Bottom(0).whc_Width(106)
            self.tableView.mj_header.beginRefreshing()
        }).disposed(by: self.disposeBag)
        
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        })
        
        return topView
        
    }


}
extension RemindController:UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: remindCell, for: indexPath)
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let provider = MoyaProvider<LoginApi>()
        var datas = [Data]()
        let image = UIImage.init(named: "bg_login")
        
        let data : Data = image!.pngData()!
        datas.append(data as Data)
        datas.append(data as Data)
    
        var receievedResponse: Response?
        var receivedError: Error?
        //开始上传图片
        provider.request(.uploadFile(imageDatas: datas)) { result in
            switch result {
            case .success(let response):
                receievedResponse = response
                let str = String(data: receievedResponse!.data, encoding: String.Encoding.utf8)
                let jsonData = try? JSONSerialization.jsonObject(with: receievedResponse!.data, options: .mutableContainers)
                print(str!)
                print(jsonData!)
            case .failure(let error):
                receivedError = error
                print(receivedError.debugDescription)
            }
        }
        
       
    }
    
   
    
}
