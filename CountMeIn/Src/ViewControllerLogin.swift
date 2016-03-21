//
//  ViewControllerLogin.swift
//  Wao
//
//  Created by zhaochenjun on 16/1/9.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerLogin: UIViewController, WXApiDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Override point for customization after application launch.

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(), forBarMetrics: UIBarMetrics.Default)
            
        self.navigationController!.navigationBar.shadowImage = UIImage.init()
        
        self.navigationController!.navigationBar.translucent = true;
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage.init(named: "navi.png"), forBarMetrics: UIBarMetrics.Default)
        
        self.navigationController!.navigationBar.shadowImage = nil
        
        self.navigationController!.navigationBar.translucent = true;
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"onRecviceWX_CODE_Notification:", name: "WX_CODE", object: nil)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "WX_CODE", object: nil)
    }

    @IBAction func signUpAction(sender: AnyObject) {
        let registerVC = UIStoryboard.init(name: "SBRegisterMobile", bundle: nil).instantiateViewControllerWithIdentifier("viewControllerRegisterMobile") as! ViewControllerRegisterMobile
        navigationController?.pushViewController(registerVC, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //微信登录 第一步
    func sendWXAuthRequest(){
        
        let req : SendAuthReq = SendAuthReq()
        req.scope = "snsapi_userinfo"
        WXApi .sendReq(req)
    }
    
    func onRecviceWX_CODE_Notification(notification:NSNotification)
    {
        var userinfoDic : Dictionary = notification.userInfo!
        getAccess_token(userinfoDic["code"] as! String)
    }
    
    //获取token 第三步
    func getAccess_token(code :String){

        Alamofire.request(.GET, URL_WECHAT_ACCESSTOKEN, parameters: ["appid": weChatAppid, "secret": weChatSecret, "code": code, "grant_type": "authorization_code"]).responseJSON {response in
            
            if let JSON = response.result.value {
                
                let token: String = JSON.objectForKey("access_token") as! String
                let openid: String = JSON.objectForKey("openid") as! String
                
                self.getUserInfo(token, openid: openid)

            }
            
        }
        
    }
    
    //获取用户信息 第四步
    func getUserInfo(token :String,openid:String){
        
        Alamofire.request(.GET, URL_WECHAT_USERINFO, parameters: ["openid": openid, "access_token": token]).responseJSON {response in
            
            if let JSON = response.result.value {
                
                let weChatInfo = [KEY_NICKNAME: JSON.objectForKey(KEY_NICKNAME) as! String, KEY_UNIONID: JSON.objectForKey(KEY_UNIONID) as! String, KEY_AVATAR: JSON.objectForKey(KEY_AVATAR) as! String]
                
                userDefaults.setObject(weChatInfo, forKey: KEY_WECHATINFO)
                
                var storyboard: UIStoryboard
                storyboard = UIStoryboard.init(name: "SBRegisterMobile", bundle: nil)
                
                var viewController: ViewControllerRegisterMobile
                viewController = storyboard.instantiateViewControllerWithIdentifier("viewControllerRegisterMobile") as! ViewControllerRegisterMobile
                
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
            
        }
        
        
    }
    
    @IBAction func buttonWeChatLogin(sender: AnyObject) {
        
        WXApi.registerApp(weChatAppid)
        
        sendWXAuthRequest()
        
    }
    
}



