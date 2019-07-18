//
//  BaseNavViewController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/11.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import QMUIKit
class BaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // 实现全屏 Pop 手势实现：
        //1. 获取系统的 Pop 手势
        guard let systemGes = interactivePopGestureRecognizer else {
            return
        }
        //2. 获取手势添加的 view
        guard let gesView = systemGes.view else {
            return
        }
        let targets = systemGes.value(forKey: "_targets") as?[NSObject]
        guard let targetObjc = targets?.first else {
            return
        }
        //3.2 取出 target
        
        guard let target = targetObjc.value(forKey: "target") else {
            return
        }
        let action = Selector(("handleNavigationTransition:"))
        //4. 创建自己的 Pan 手势
//        let panGes = UIPanGestureRecognizer()
//        gesView.addGestureRecognizer(panGes)
//        panGes.addTarget(target, action: action)
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:threeColor!,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)]
        
        self.navigationBar.setBackgroundImage(UIImage.qmui_image(with: UIColor.white), for: .default)
        self.navigationBar.shadowImage = UIImage.init()
        
        
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let leftBtn = UIButton.init()
            leftBtn.setImage(UIImage.init(named: "leftreturn"), for: .normal)
            
            leftBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            
            let leftItem = UIBarButtonItem.init(customView: leftBtn)
            
            viewController.navigationItem.leftBarButtonItem = leftItem
            
        }
        super.pushViewController(viewController, animated: true)
        
        
    }
    @objc func goBack()  {
        self.popViewController(animated: true)
    }
    
}
