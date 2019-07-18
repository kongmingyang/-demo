//
//  RemindCell.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/15.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit

class RemindCell: UITableViewCell {

    @IBOutlet weak var telBtn: UIButton!
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var stateLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.stateLb.layer.cornerRadius = 9
        self.stateLb.layer.masksToBounds = true
        
        
    }

  
    
}
