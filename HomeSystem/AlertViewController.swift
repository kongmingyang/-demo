//
//  AlertViewController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/16.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
protocol AlertViewControllerDelegate:NSObjectProtocol {
    func didSelectedItem(tag:AlertBtnType)
}
class AlertViewController: UIViewController {
    var delegate : AlertViewControllerDelegate?
    
    var leftTitle : String?
    var rightTitle : String?
    var titleItem : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let alertView = AlertView.init(frame: CGRect.zero, title: self.titleItem!, leftBtnTitle: self.leftTitle!, rightBtnTitle: self.rightTitle!)
        alertView.alertViewDelegate = self
        self.view.addSubview(alertView)
        
        alertView.whc_Left(53).whc_Right(53).whc_Height(115).whc_CenterY(0)
    }
    
    


}
extension AlertViewController:AlertViewDelegate {
    func didSelected(tag: AlertBtnType) {
        self.dismiss(animated: true, completion: nil)
        if self.delegate != nil {
            self.delegate?.didSelectedItem(tag: tag)
        }
    }
    
    
    
}
