//
//  LoginApi.swift
//  HomeSystem
//
//  Created by 明孔 on 2019/7/15.
//  Copyright © 2019 明孔. All rights reserved.
//

import UIKit
import Moya
import QMUIKit

public enum LoginApi{
    
    case login(phoneNo:String,password:String) //登录
    case register(phoneNo:String,codeNo:String,password:String) //注册
    case forgetPassword(phoneNo:String,codeNo:String,password:String) //忘记密码
    case getMobileCode(phoneNo:String) //获取验证码
    case getRepairListDatas(type:String,page:String,pageSize:String)
    case uploadFile(imageDatas:Array<Data>) //上传图片
    
}

extension LoginApi:TargetType{
    //设置请求头
    public var headers: [String : String]? {
        let infoDic:Dictionary = Bundle.main.infoDictionary!
        let app_version:String = infoDic["CFBundleShortVersionString"] as! String
        
        let model =  UserInfoTool.shared.userModel()
        var token = ""
        
        if model.token!.count > 1 {
            token = model.token!
        }

        return ["Accept":"application/json","Content-Type":"application/json; charset=utf-8","x-client-system":"ios","x-client-systemVersion":UIDevice.current.systemVersion,"x-client-appVersion":app_version,"x-user-token":token]
    }
    
    
    //设置ip
    public var baseURL: URL {
        
        return URL.init(string: "http://182.140.221.106:12219/")!
        
    }
    //方法名
    public var path: String {
        switch self {
        case .login( _,_):
            return "login"
            
        case .register(_,_,_):
            return "register"
            
        case .forgetPassword(_,_,_):
            return "forgetPassword"
            
        case .getMobileCode(_):
            return "mobile/code"
        case .getRepairListDatas(_, _,_):
            return "repair/getMaintainRecords"
        case .uploadFile(_):
            return "oss/uploadImages"
        }
      
   
        
    }
    //各个方法的请求方式
    public var method: Moya.Method {
        switch self {
        case .login,.register,.forgetPassword,.getRepairListDatas,.uploadFile:
            return .post
            
        case .getMobileCode:
            return .get
        }
        
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    //各个请求任务
    public var task: Task {
        switch self {
        case .login(let phoneNo,let password):
            return .requestParameters(parameters: ["mobile":phoneNo,"pwd":password], encoding: JSONEncoding.default)
        case .register(let phoneNo,let codeNo,let password):
            
            return .requestParameters(parameters: ["tel":phoneNo,"validCode":codeNo,"regpsw":password], encoding:JSONEncoding.default)
            
        case .forgetPassword(let phoneNo, let codeNo, let password):
            return .requestParameters(parameters: ["mobile":phoneNo,"verCode":codeNo,"regpsw":password], encoding:JSONEncoding.default)
            
        case .getMobileCode(let phoneNo):
            
            return .requestParameters(parameters: ["mobile":phoneNo], encoding: URLEncoding.queryString)
            
        case .getRepairListDatas(let type, let page, let pageSize):
            
            return .requestParameters(parameters: ["type":type,"":page,"10":pageSize], encoding: URLEncoding.queryString)
            
            //TODO:上传图片
        case .uploadFile(let imageDatas):
            var multiParDatas = [MultipartFormData]()
            
            for multiData in imageDatas {
                let formData = MultipartFormData(provider: .data(multiData ), name:String.init(describing:arc4random()%10 ) , fileName: String.init(describing:arc4random()%5), mimeType: "image/png")
                multiParDatas.append(formData)
            }
//            let imgUrl = URL.init(string: "http://img5.imgtn.bdimg.com/it/u=2380892543,1075553238&fm=26&gp=0.jpg")
            let imgUrl = URL.init(fileURLWithPath: Bundle.main.path(forResource: "filePath", ofType: ".jpg")!)
            
            let urlData = (imgUrl.dataRepresentation)
           
            
            let formData1 = MultipartFormData(provider: .data(urlData), name: "netImg", fileName: "workImg", mimeType: "image/jpg")
            
            //上传url  file需要是本地文件
            let formData2 = MultipartFormData(provider: .file(imgUrl), name: "netImg", fileName: "urlImg", mimeType: "image/jpg")
            
           multiParDatas.append(formData1)
            multiParDatas.append(formData2)
            let params:[String:Any] = ["files":imageDatas,"folder":"1"]
        
            return .uploadCompositeMultipart(multiParDatas, urlParameters: params)
        }
        
        
        
    }
    
}

