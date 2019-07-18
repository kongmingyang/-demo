//
//  SetViewController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/12.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit

class SetViewController: BaseViewController {

    @IBOutlet weak var changePassWordBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.navigationItem.title = "设置"
        
        
    }

    @IBAction func changeClcik(_ sender: Any) {
        
        
    }
    
    @IBAction func loginOutClcik(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController = LoginViewController.init()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
