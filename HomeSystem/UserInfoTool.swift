
//
//  UserInfoTool.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/16.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import HandyJSON

class UserInfoTool: NSObject {
    public var userInfo =  UserInfo()
    
    static let shared = UserInfoTool()
    
    func getUserInfo(dic:[String:Any])  {
        
        
        
        let modelData = NSKeyedArchiver.archivedData(withRootObject: dic)
        
        print(dic)
        UserDefaults.standard.set(modelData , forKey: "userInfo")
        UserDefaults.standard.synchronize()
        
    }
    public  func userModel()-> UserInfo {
        
        let  modelData = UserDefaults.standard.object(forKey: "userInfo")
        let json:[NSString:Any] =  NSKeyedUnarchiver.unarchiveObject(with: modelData as! Data) as! [NSString : Any]
        let model = UserInfo.deserialize(from: json as [String : Any])
        
        return model!
        
    }
    
}
