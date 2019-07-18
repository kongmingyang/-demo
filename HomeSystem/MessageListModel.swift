//
//  MessageListModel.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/17.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import HandyJSON

struct  MessageListModel: HandyJSON {
    var startLevel: String?
    var exigenceTypeName: String?
    var repairsType: String?
    var maintainDate: String?
    var picture: String?
    var repairsTypeName: String?
    var statusName: String?
    var isRead: String?
    var errorDescription: String?
    var maintainId: String?
    var exigenceType: String?
    var repairsOdd: String?
    var status: String?
    var detailedAddress: String?
}
