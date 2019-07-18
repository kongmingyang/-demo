//
//  MessageCell.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/15.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

//    public var listModel : MessageListModel!
    
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    //TODO:Set方法
    
    var listModel = MessageListModel(){
        didSet{
            DispatchQueue.main.async {
                self.contentLb.text = self.listModel.repairsTypeName
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.masksToBounds = true
        self.bgView.layer.cornerRadius = 8
         self.contentLb.text = "希望工程"
       
    }
    public func reloadUI(){
        
//        DispatchQueue.main.async {
//        self.contentLb.text = self.listModel.repairsTypeName
//        }
       
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
