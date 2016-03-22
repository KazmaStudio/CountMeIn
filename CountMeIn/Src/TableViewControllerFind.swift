//
//  TableViewController.swift
//  actionsheet
//
//  Created by 袁思曾 on 16/3/18.
//  Copyright © 2016年 袁思曾. All rights reserved.
//

import UIKit
import Alamofire

class TableViewControllerFind: UITableViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            showActionSheet()
        }
    }
    
    func showActionSheet() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let importFromWeixin = UIAlertAction(title: "从微信导入", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.buttonWeChatLogin()
            
        })
        let importFromContact = UIAlertAction(title: "从通讯录导入", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Saved")
        })
        
        let shareToPengyouquan = UIAlertAction(title:"分享到朋友圈",style:.Default,handler:{
            (alert:UIAlertAction!)  -> Void in
            
            //self.sendText("test test test From SERENA", inScene: WXSceneTimeline)
        
            
            //self.sendImage(UIImage(named: "dousen.jpg")!, inScene:WXSceneTimeline)
            
            self.sendLinkContent(WXSceneTimeline)
        })
        
        let shareToFriend = UIAlertAction(title:"分享给好友",style:.Default,handler:{
            (alert:UIAlertAction!)  -> Void in
            //self.sendText("test test test From SERENA", inScene: WXSceneSession)
            self.sendLinkContent(WXSceneSession)
            
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(importFromWeixin)
        optionMenu.addAction(importFromContact)
        optionMenu.addAction(shareToPengyouquan)
        optionMenu.addAction(shareToFriend)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func buttonWeChatLogin() {
        
        
        sendWXAuthRequest()
        
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
    
    
//微信分享
    
    
    
   
    
   
    
//    //分享文本
    func sendText(text:String, inScene: WXScene)->Bool{
        let req=SendMessageToWXReq()
        req.text=text
        req.bText=true
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    ///分享图片
    func sendImage(image:UIImage, inScene:WXScene)->Bool{
        let ext=WXImageObject()
        ext.imageData=UIImagePNGRepresentation(image)
        
        let message=WXMediaMessage()
        message.title=nil
        message.description=nil
        message.mediaObject=ext
        message.mediaTagName="MyPic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.drawInRect(CGRectMake(0, 0, 100, 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage)
        
        let req=SendMessageToWXReq()
        req.text=nil
        req.message=message
        req.bText=false
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)

    }
//分享连接
    
    func sendLinkContent(inScene:WXScene) {
    let message =  WXMediaMessage()
    
    message.title = "test test"
    message.description = "test From SERENA"
    message.setThumbImage(UIImage(named:"katy2.jpg"))
    
    let ext =  WXWebpageObject()
    ext.webpageUrl = "http://hangge.com"
    message.mediaObject = ext
    
    let req =  SendMessageToWXReq()
    req.bText = false
    req.message = message
    req.scene=Int32(inScene.rawValue)
    WXApi.sendReq(req)
    }

    
  
    
    func onResp(resp: BaseResp!) {
        if resp.isKindOfClass(SendMessageToWXResp){//确保是对我们分享操作的回调
            if resp.errCode == WXSuccess.rawValue{//分享成功
                NSLog("分享成功")
            }else{//分享失败
                NSLog("分享失败，错误码：%d, 错误描述：%@", resp.errCode, resp.errStr)
            }
        }
    }

    
    
    
    
    


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
