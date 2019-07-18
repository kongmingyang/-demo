//
//  UserInfo.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/16.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import HandyJSON

struct UserInfo:HandyJSON {
    var type: String?
    var id: String?
    var officeList: [OfficeList]?
    var name: String?
    var token: String?
    var picUrl: String?
    var ruleName :String?
}
struct OfficeList:HandyJSON {
    
    var isUser: String?
    var haveUser: String?
    var haveChildOffice: String?
    var departmentName: String?
    var schoolId: String?
    var schoolName: String?
    var departmentId: String?
    var type: String?
    var userList: String?
    var childOfficeeList: String?
    
    
}
