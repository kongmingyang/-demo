//
//  AlertView.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/16.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
protocol AlertViewDelegate : NSObjectProtocol{
    func didSelected(tag:AlertBtnType)
    
}
enum AlertBtnType:Int {
    case cancle = 0
    case confirm = 1
}
class AlertView: UIView {

    let disposed = DisposeBag()
    public  var alertBtnType = AlertBtnType.cancle

    
    var alertViewDelegate : AlertViewDelegate?
    
     init(frame: CGRect, title:String, leftBtnTitle:String,rightBtnTitle:String) {
       super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.white
        let titleLb = UILabel.init()
        titleLb.textAlignment = .center
        titleLb.font = UIFont.systemFont(ofSize: 16)
        titleLb.textColor = threeColor
        titleLb.text = title
        self.addSubview(titleLb)
        let hline =  UIView.init()
        hline.backgroundColor = UIColor.qmui_color(withHexString: "#F1F2F3")
        self.addSubview(hline)
        
        let vline = UIView.init()
        vline.backgroundColor = UIColor.qmui_color(withHexString: "#F1F2F3")
        self.addSubview(vline)
        
        let cancleBtn = self.setupButton(title: leftBtnTitle)
        cancleBtn.tag = AlertBtnType.cancle.rawValue
        cancleBtn .setTitleColor(threeColor, for: .normal)
        let rightBtn = self.setupButton(title: rightBtnTitle)
        rightBtn.tag = AlertBtnType.cancle.rawValue
        rightBtn.setTitleColor(UIColor.qmui_color(withHexString: "#0B98FF"), for: .normal)
          self.addSubview(rightBtn)
        if leftBtnTitle.count > 0 {
            self.addSubview(cancleBtn)
            cancleBtn.whc_Left(0).whc_Top(0, toView: hline).whc_WidthEqual(self, ratio: 0.49).whc_Height(50)
            rightBtn.whc_Right(0).whc_TopEqual(cancleBtn).whc_WidthEqual(self, ratio: 0.49).whc_Height(50)
        }else{
            rightBtn.whc_Left(0).whc_Right(0).whc_Top(0, toView: hline).whc_Height(50)
        }
      
        titleLb.whc_Left(0).whc_Right(0).whc_Height(16).whc_Top(24)
        hline.whc_Left(0).whc_Right(0).whc_Height(1).whc_Top(24, toView: titleLb)
        vline.whc_CenterX(0).whc_Top(0, toView: hline).whc_Width(1).whc_Height(50)
        
        cancleBtn.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            if self!.alertViewDelegate != nil{
                self!.alertViewDelegate?.didSelected(tag: .cancle)
            }
            
        }).disposed(by:self.disposed )
        rightBtn.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            if self!.alertViewDelegate != nil{
                self!.alertViewDelegate?.didSelected(tag: .confirm)
            }
            
        }).disposed(by:self.disposed )
        
        
        
        
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton(title:String) -> UIButton {
        
        let button = UIButton.init()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
        
        
    }
    
}
