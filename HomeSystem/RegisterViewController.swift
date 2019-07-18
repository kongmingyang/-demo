//
//  RegisterViewController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/15.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var confirmField: QMUITextField!
    
    @IBOutlet weak var wordBtn: UIButton!
    @IBOutlet weak var passWordBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var passwordField: QMUITextField!
    @IBOutlet weak var userNameField: QMUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationItem.title = "注册"
        self.wordBtn.isSelected = true
        self.passWordBtn.isSelected = true
        self.confirmBtn.layer.cornerRadius  = 8
        self.confirmBtn.layer.masksToBounds = true
      self.confirmField.isSecureTextEntry = true
         self.passwordField.isSecureTextEntry = true
    }

    @IBAction func confirmPassWordClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
             self.confirmField.isSecureTextEntry = true
        }else{
           self.confirmField.isSecureTextEntry = false
        }
        
       
      
       
    }
    
    @IBAction func passWordClick(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.passwordField.isSecureTextEntry = true
        }else{
            self.passwordField.isSecureTextEntry = false
        }
        
    }
    @IBAction func comfirmClick(_ sender: Any) {
        print("确认修改")
        
    }
    

    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
