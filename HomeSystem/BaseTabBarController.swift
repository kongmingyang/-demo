//
//  BaseTabBarController.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/11.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor :sixColor as Any ], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor.blue ], for: .selected)
        self.tabBar.backgroundImage = UIImage.qmui_image(with: UIColor.white)
        let home = HomeViewController.init()
        let homeNav = BaseNavViewController.init(rootViewController: home)

        self.setupChildboard(viewController: homeNav, image: "", selectedImage: "", title: "首页")
        self.viewControllers = [homeNav]
    }
    
    func setupChildboard(viewController:UIViewController,image:String,selectedImage:String,title:String)  {
        viewController.tabBarItem.title = title
        let normoalImg = UIImage.init(named: image)?.withRenderingMode(.alwaysOriginal)
        let selectedImg = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        
        viewController.tabBarItem.image = normoalImg
        
        viewController.tabBarItem.selectedImage = selectedImg
        
    }
    



}
