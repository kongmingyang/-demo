//
//  HomeViewController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/11.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WHC_Layout

class HomeViewController: BaseViewController {
    let disposed = DisposeBag()
  
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.backgroundColor = UIColor.white
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.qmui_image(with: UIColor.white), for: .default)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//       self.navigationController?.navigationBar.isTranslucent = true
//       self.navigationController?.navigationBar.backgroundColor = UIColor.clear
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.qmui_image(with: UIColor.clear), for: .default)
      
        
       
        let  gradientlayer = CAGradientLayer.init()
        let bgView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 190))
         self.view .addSubview(bgView)
    
          bgView.layer.addSublayer(gradientlayer)
       
        gradientlayer.frame = bgView.bounds
        gradientlayer.startPoint  = CGPoint.init(x: 0, y: 0)
        gradientlayer.endPoint = CGPoint.init(x: 1, y: 0)
        gradientlayer.colors = [UIColor.qmui_color(withHexString: "#0080FF")?.cgColor as Any,UIColor.qmui_color(withHexString: "#1EC0FF")?.cgColor as Any]
        gradientlayer.locations = [0,1.0];
        let systemNewBtn = self.setupButton(image: "system_news")
        let setBtn = self.setupButton(image: "system_setting")
        self.view.addSubview(systemNewBtn)
        self.view.addSubview(setBtn)
        setBtn.whc_Right(15).whc_Top(40, false).whc_Width(20).whc_Height(20)
        systemNewBtn.whc_Right(20, toView: setBtn).whc_Top(40, false).whc_Width(20).whc_Height(20)
        
        setBtn.rx.tap.subscribe(onNext: {
              DispatchQueue.main.async {
            
            let set = SetViewController.init()
            self.navigationController?.pushViewController(set, animated: true)
            }
            
            
        }).disposed(by: disposed)
        
        systemNewBtn.rx.tap.subscribe(onNext: { 
            print("点击按钮")
            DispatchQueue.main.async {
                let messageVC = MessageListController.init()
                self.navigationController?.pushViewController(messageVC, animated: true)
            }
          
            
            }).disposed(by: disposed)
        
        let model =  UserInfoTool.shared.userModel()
        
        let userIcon   = UIImageView.init()
        userIcon.image = UIImage.init(named: "home_pic")
        self.view.addSubview(userIcon)
        userIcon.whc_Top(12, toView: setBtn).whc_Left(15).whc_Width(50).whc_Height(50);
        
        let nameLb     = self.setupLabel(title: model.name!, font: 16)
        let positionLb = self.setupLabel(title: "置业顾问", font: 13)
       self.view.addSubview(nameLb)
        self.view.addSubview(positionLb)
        nameLb.whc_Left(10, toView: userIcon).whc_TopEqual(userIcon, offset: 0).whc_WidthAuto().whc_Height(16)
        positionLb.whc_Left(10, toView: userIcon).whc_BottomEqual(userIcon).whc_WidthAuto().whc_Height(16)

        let locationLb = UILabel.init(frame: CGRect(x: self.view.qmui_width-188, y: 82, width: 188, height: 40))
        locationLb.textColor = UIColor.white
        locationLb.font = UIFont.systemFont(ofSize: 14)
        locationLb.text = "蓝光幸福满庭"
        locationLb.textAlignment = .center
        locationLb.backgroundColor = UIColor.init(white: 1, alpha: 0.25)
        self.view.addSubview(locationLb)
        
        let corners:UIRectCorner = [.bottomLeft,.topLeft]
        
        let path = UIBezierPath.init(roundedRect: locationLb.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 20, height: 20))
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        locationLb.layer.mask = layer
        
        let scrollView = UIScrollView.init()
        scrollView.backgroundColor = UIColor.clear
        self.view .addSubview(scrollView)
        
        scrollView.whc_Top(20, toView: userIcon).whc_Left(0).whc_Right(0).whc_Bottom(0)
        
        let functionView = self.setupView()
        scrollView.addSubview(functionView)
       functionView.whc_Top(0).whc_Left(15, toView: self.view).whc_Right(15, toView: self.view).whc_Height(83)
        
       
        
        let statisticsView = self.businessStatisticsView(titles: ["欠款总计","销售总计","今日待跟进","逾期未跟进","客户总数"], moneys:["0","0","0","0","0"] , colors: ["#F25C61","#22A5F7","#FFBC0B","#FF8E3D","#8A77ED"])
        scrollView.addSubview(statisticsView)
        
        statisticsView.whc_Left(15, toView: self.view).whc_Right(15, toView: self.view).whc_Top(10, toView: functionView).whc_HeightAuto().whc_Bottom(10)
        
 

    }

 

}
extension HomeViewController {
    
    func setupLabel(title:String,font:CGFloat) -> UILabel {
        
        let label = UILabel.init()
        label.text = title
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: font)
        
        return label
        
    }
    
    func setupButton(image:String) -> QMUIButton {
        let button = QMUIButton.init()
        button.setImage(UIImage.init(named: image), for: .normal)
        
        return button
        
    }
    
    func setupView() -> UIView {
        
        let bgView = UIView.init()
        bgView.backgroundColor = UIColor.white
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius  = 8
        
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.qmui_color(withHexString: "#F1F2F3")
        bgView.addSubview(lineView)
        lineView.whc_CenterX(0).whc_Top(15).whc_Bottom(15).whc_Width(1)
        
        let btn1 = self.setupButton(image: "home_remind")
        btn1.imagePosition = .top
        btn1.contentHorizontalAlignment = .center
        btn1.setTitle("跟进提醒", for: .normal)
        btn1.rx.tap.subscribe(onNext: { [weak self] in
            
            let  remindVC = RemindController.init()
            self?.navigationController?.pushViewController(remindVC, animated: true)
            
            
            
        }).disposed(by: disposed)
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn1.titleEdgeInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        btn1.setTitleColor(sixColor, for: .normal)
        bgView.addSubview(btn1)
        
        let btn2 = self.setupButton(image: "home_customer")
        btn2.imagePosition = .top
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn2.setTitle("客户资源", for: .normal)
        btn2.contentHorizontalAlignment = .center
        btn2.titleEdgeInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        btn2.setTitleColor(sixColor, for: .normal)
        btn2.rx.tap.subscribe(onNext: { [weak self] in
//
//            let  choosePicker = ChoosePickerController.init()
//            choosePicker.modalPresentationStyle = .overCurrentContext
//           //接受闭包传值
//            choosePicker.itemBlock = {
//                (selectItem:String) -> (Void) in
//                print(selectItem)
//            }
//            self?.present(choosePicker, animated: true, completion: nil)
         let customVC = CustomerResouceController.init()
            self?.navigationController?.pushViewController(customVC, animated: true)
            
            
        }).disposed(by: disposed)
        bgView.addSubview(btn2)
        
        btn1.whc_Left(0).whc_Top(0).whc_Bottom(0).whc_WidthEqual(bgView, ratio: 0.49)
        btn2.whc_Right(0).whc_Top(0).whc_Bottom(0).whc_WidthEqual(bgView, ratio: 0.49)
        
        
        return bgView
    
        
    }
    //stackView
    func businessStatisticsView(titles:[String],moneys:[String],colors:[String]) -> UIView {
        
        let staticsView = UIView.init()
        staticsView.backgroundColor = UIColor.white
        
        let label = UILabel.init()
        label.text = "业务统计"
        label.textColor = threeColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        staticsView.addSubview(label)
        
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.qmui_color(withHexString: "#F1F2F3")
        staticsView.addSubview(lineView)
        lineView.whc_CenterX(0).whc_Top(15).whc_Bottom(15).whc_Width(1)
        
        let stackView = WHC_StackView.init()
        stackView.backgroundColor = UIColor.clear
//        stackView.whc_Edge = UIEdgeInsets.init(top: 1, left: 0, bottom: 0, right: 1)
        stackView.whc_Column = 2;
        stackView.whc_Orientation = .all
        stackView.whc_HSpace = 1
        stackView.whc_VSpace = 1;
        staticsView.backgroundColor = UIColor.clear
        
        for i in 0...titles.count-1 {
            let contenView = self.contenView(moneyNumber: moneys[i], color: colors[i], title: titles[i])
            stackView.addSubview(contenView)
        }
        
        staticsView .addSubview(stackView)
        stackView.whc_Left(0).whc_Right(0).whc_Top(0).whc_HeightAuto().whc_Bottom(10)

        stackView.whc_StartLayout()
        
       return staticsView
        
    }
    
    func contenView(moneyNumber:String,color:String, title:String) -> UIView {
        let contentView = UIView.init()
        contentView.backgroundColor = UIColor.white
        let locationLb = UILabel.init()
        locationLb.textColor = sixColor
        locationLb.font = UIFont.systemFont(ofSize: 15)
        locationLb.text = title
        locationLb.textAlignment = .center
        contentView.addSubview(locationLb)
        
        let moneyLb = UILabel.init()
        moneyLb.textColor = UIColor.qmui_color(withHexString: color)
        moneyLb.font = UIFont.systemFont(ofSize: 24)
        moneyLb.text = moneyNumber
        moneyLb.textAlignment = .center
        contentView.addSubview(moneyLb)
        
        let btn1 = self.setupButton(image: "")
        btn1.rx.tap.subscribe(onNext: { () in
            print(title)
        }).disposed(by: disposed)
        contentView.addSubview(btn1)
        
        locationLb.whc_Left(0).whc_Right(0).whc_Height(23).whc_Top(28)
        moneyLb.whc_Left(0).whc_Right(0).whc_Height(23).whc_Top(22, toView: locationLb).whc_Bottom(27)
        btn1.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        
        return contentView
    }
    
}
