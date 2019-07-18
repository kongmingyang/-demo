//
//  LoginViewController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/11.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
class LoginViewController: UIViewController {
  
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passWordField: QMUITextField!
    @IBOutlet weak var userNameField: QMUITextField!
    let disposeBag = DisposeBag()
   // override 重写父类方法  final关键字 利用final关键字防止重写
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.layer.cornerRadius = 22;
        self.userNameField.tintColor = UIColor.white
        self.passWordField.tintColor = UIColor.white
        self.passWordField.isSecureTextEntry = true
        self.passWordField.textInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
        self.userNameField.textInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 0)
        
        self.userNameField.rx.text.orEmpty.asObservable().subscribe(onNext: {
            print("您输入的是：\($0)")
            
        }).disposed(by: disposeBag)
        
        self.passWordField.rx.text.orEmpty.asObservable().subscribe(onNext: {
            print("您输入的是：\($0)")
            
        }).disposed(by: disposeBag)
     
 
        let phoneNo =  UserDefaults.standard.string(forKey: "phoneNo")
        let number = UserDefaults.standard.string(forKey: "password")
        
        guard phoneNo == nil else {
            self.userNameField.text = phoneNo
            self.passWordField.text = number
            
            return
        }
    }

    // MARK:登录事件
    @IBAction func loginClick(_ sender: Any) {

//        DispatchQueue.main.async {
//            let home = HomeViewController.init()
//            let homeNav = BaseNavViewController.init(rootViewController: home)
//
//            UIApplication.shared.keyWindow?.rootViewController = homeNav
//
//        }
//
        
        MBProgressHUD.showLoading("登录中")
        let provider = MoyaProvider<LoginApi>()
        provider.request(.login(phoneNo: self.userNameField.text!, password: self.passWordField.text!)) { (result) in
        MBProgressHUD.hide()
            switch result{
            case let .success(response):
//                let str = String(data: response.data, encoding: String.Encoding.utf8)
                let jsonString = try?JSONSerialization.jsonObject(with: response.data, options: .mutableContainers)
                let dic:[String:Any] = jsonString  as! [String : Any];

                let code:String = dic["code"] as!String
                let msg:String = dic["msg"] as!String
                UserDefaults.standard.setValue(self.userNameField.text!, forKey: "phoneNo")
                UserDefaults.standard.setValue(self.passWordField.text!, forKey: "password")
                UserDefaults.standard.synchronize()
                guard code=="000000" else{
                    MBProgressHUD.hide()
                    MBProgressHUD .showError(msg)
                    return
                }
                let json:[String:Any] = dic["data"] as![String:Any]

                UserInfoTool.shared.getUserInfo(dic: json)
                DispatchQueue.main.async {
                    let home = HomeViewController.init()
                    let homeNav = BaseNavViewController.init(rootViewController: home)

                    UIApplication.shared.keyWindow?.rootViewController = homeNav

                }

                break
            case let .failure(failer):

                MBProgressHUD.hide()
                print(failer.errorUserInfo)
                MBProgressHUD.showError(String.init(describing:"请求失败" ))

                break
            }
        }


        
        
    }
    
    @IBAction func reigster(_ sender: Any) {
        
       let registerVC = RegisterViewController.init()
        self.present(registerVC, animated: true, completion: nil)
        
        
    }
    

}
