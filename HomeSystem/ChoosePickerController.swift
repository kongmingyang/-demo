//
//  ChoosePickerController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/16.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//闭包传值
typealias chooseItemBlock = (_ selectItem:String) -> Void
class ChoosePickerController: BaseViewController {
 
    var pickerView : UIPickerView!
    var idTypes : Array<Any>!
    let disposeBag = DisposeBag()
    var selectedItem = String()
    var itemBlock : chooseItemBlock?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        self.idTypes = ["身份证","护照"]
        let topView:UIView = self.setupTopView()
        topView.backgroundColor = UIColor.qmui_color(withHexString: "#F5F6F8")
        self.view.addSubview(topView)
        
      self.pickerView = UIPickerView.init()
      pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        self.view.addSubview(pickerView)
       
        topView.whc_Bottom(176).whc_Left(0).whc_Right(0).whc_Height(44)
        self.pickerView.whc_Bottom(0).whc_Left(0).whc_Right(0).whc_Height(176)
        self.selectedItem = self.idTypes.first as! String
        
    }
    
    func setupTopView() -> UIView {
        
        let topView = UIView.init()
        let cancleBtn = self.setupButton(title: "取消")
        cancleBtn.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).disposed(by:self.disposeBag )
        
        let confirmBtn = self.setupButton(title: "确定")
        confirmBtn.rx.tap.subscribe(onNext: {
           //闭包传值
            if self.itemBlock != nil {
                self.itemBlock!(self.selectedItem)
            }
            
            self.dismiss(animated: true, completion: nil)
            
        }).disposed(by:self.disposeBag)
        let titleLb = UILabel.init()
        titleLb.text = "选择证件类型"
        titleLb.font = font15
        topView.addSubview(cancleBtn)
        topView.addSubview(confirmBtn)
        topView.addSubview(titleLb)
        
        cancleBtn.whc_Left(0).whc_CenterY(0).whc_Height(44).whc_Width(50)
        confirmBtn.whc_Right(0).whc_CenterY(0).whc_Height(44).whc_Width(50)
        titleLb.whc_Center(0, y: 0).whc_WidthAuto().whc_Height(44)
        
        
        
        return topView
        
    }
    
    func setupButton(title:String) -> UIButton  {
        let button = UIButton.init()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.qmui_color(withHexString: "#0B98FF"), for: .normal)
        return button
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.dismiss(animated: true, completion: nil)
    }

}
extension ChoosePickerController : UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 2
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.idTypes![row] as? String
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        self.selectedItem = self.idTypes[row] as! String
     
    }
    
    
}
