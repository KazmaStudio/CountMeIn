//
//  ViewControllerRegisterMobile.swift
//  Wao
//
//  Created by zhaochenjun on 16/1/9.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit
import Kingfisher

class ViewControllerRegisterMobile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var textFieldNickname: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    
    
    
    
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    var isFullScreen: Bool = false
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.keyboardDismissMode = .OnDrag

        
//        let weChatInfo = userDefaults.objectForKey(KEY_WECHATINFO)
        
//        let avatarUrl = weChatInfo!.objectForKey(KEY_AVATAR) as! String
    
//        self.imageViewAvatar.kf_setImageWithURL(NSURL(string: avatarUrl)!)
        
//        let nickname = weChatInfo!.objectForKey(KEY_NICKNAME) as! String
        
//        self.textFieldNickname.text = nickname
        
        let tapImage = UITapGestureRecognizer(target: self, action: "changeImage:")
        imageViewAvatar.addGestureRecognizer(tapImage)
        imageViewAvatar.userInteractionEnabled = true

    }

    func changeImage(sender :UIButton){
        // 设置代理
                self.imagePickerController.delegate = self
                 // 设置是否可以管理已经存在的图片或者视频
                 self.imagePickerController.allowsEditing = true
        
                 // 判断是否支持相机
                 if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
                        let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                         //在iPad上使用表单（ActionSheet）需要设置描点(anchor point)
                         let popover = alertController.popoverPresentationController
                         if (popover != nil){
                                 popover?.sourceView = sender
                                popover?.sourceRect = sender.bounds
                                popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
                            }
            
                         let cameraAction: UIAlertAction = UIAlertAction(title: "拍照换头像", style: .Default) { (action: UIAlertAction!) -> Void in
                                 // 设置类型
                                 self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
                                 self.presentViewController(self.imagePickerController, animated: true, completion: nil)
                             }
                       alertController.addAction(cameraAction)
            
                         let photoLibraryAction: UIAlertAction = UIAlertAction(title: "从相册选择换头像", style: .Default) { (action: UIAlertAction!) -> Void in
                                 // 设置类型
                                 self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                                 //改navigationBar背景色
                                 self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
                                 //改navigationBar标题色
                                 self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
                                 //改navigationBar的button字体色
                                 self.imagePickerController.navigationBar.tintColor = UIColor.whiteColor()
                                 self.presentViewController(self.imagePickerController, animated: true, completion: nil)
                             }
                       alertController.addAction(photoLibraryAction)
            
                         let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                         alertController.addAction(cancelAction)
        
                        presentViewController(alertController, animated: true, completion: nil)
            
                     }else{
                         let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                         //设置描点(anchor point)
                         let popover = alertController.popoverPresentationController
                         if (popover != nil){
                                 popover?.sourceView = sender
                                 popover?.sourceRect = sender.bounds
                                 popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
                             }
            
                         let photoLibraryAction: UIAlertAction = UIAlertAction(title: "从相册选择换头像", style: .Default) { (action: UIAlertAction!) -> Void in
                                 // 设置类型
                                 self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                             //改navigationBar背景色
                                 self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
                                 //改navigationBar标题色
                                 self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
                                 //改navigationBar的button字体色
                                 self.imagePickerController.navigationBar.tintColor = UIColor.whiteColor()
                                 self.presentViewController(self.imagePickerController, animated: true, completion: nil)
                             }
                       alertController.addAction(photoLibraryAction)
            
                         let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                         alertController.addAction(cancelAction)
            
                         presentViewController(alertController, animated: true, completion: nil)
                     }
             }
    
         //实现ImagePicker delegate 事件
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
            //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        // 保存图片至本地，方法见下文
        self.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 0.5, imageName: "currentImage.png")
//        let fullPath: String = NSHomeDirectory().stringByAppendingPathComponent("Documents").stringByAppendingPathComponent("currentImage.png")
        let home = NSHomeDirectory() as NSString
        let docPath = home.stringByAppendingPathComponent("Documents") as NSString
        let fullPath = docPath.stringByAppendingPathComponent("currentImage.png")
//        let fullPath: String = NSHomeDirectory().stringByAppendingString("Documents").stringByAppendingString("currentImage.png")
        //                 println("fullPath=\(fullPath)")
        let savedImage: UIImage = UIImage(contentsOfFile: fullPath)!
        self.isFullScreen = false
        self.imageViewAvatar.image = savedImage
        //在这里调用网络通讯方法，上传头像至服务器...
    }

         // 当用户取消时，调用该方法
         func imagePickerControllerDidCancel(picker: UIImagePickerController) {
                 self.dismissViewControllerAnimated(true, completion: nil)
             }
    
         //保存图片至沙盒
         func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName: String){
                //压缩图片尺寸
                 UIGraphicsBeginImageContext(newSize)
                 currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
                 let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
                 UIGraphicsEndImageContext()
                 //高保真压缩图片质量
                 //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
                 let imageData: NSData = UIImageJPEGRepresentation(newImage, percent)!
                 // 获取沙盒目录,这里将图片放在沙盒的documents文件夹中
//                 let fullPath: String = NSHomeDirectory().c("Documents").stringByAppendingPathComponent(imageName)
            let home = NSHomeDirectory() as NSString
            let docPath = home.stringByAppendingPathComponent("Documents") as NSString
            let fullPath = docPath.stringByAppendingPathComponent(imageName)
//            let fullPath: String = NSHomeDirectory().stringByAppendingPathComponent("")
//            let fullPath: String = NSHomeDirectory().stringByAppendingString("Documents").stringByAppendingString(imageName)
                 // 将图片写入文件
                imageData.writeToFile(fullPath, atomically: false)
            }

         //实现点击图片预览功能，滑动放大缩小，带动画
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isFullScreen = !self.isFullScreen
        
        let touch: UITouch = touches.first! as UITouch
        let touchPoint: CGPoint  = touch.locationInView(self.view)
        let imagePoint: CGPoint = self.imageViewAvatar.frame.origin
        //touchPoint.x ，touchPoint.y 就是触点的坐标
        // 触点在imageView内，点击imageView时 放大,再次点击时缩小
        if(imagePoint.x <= touchPoint.x && imagePoint.x + self.imageViewAvatar.frame.size.width >= touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.imageViewAvatar.frame.size.height >= touchPoint.y){
            // 设置图片放大动画
            UIView.beginAnimations(nil, context: nil)
            // 动画时间
            UIView.setAnimationDuration(1)
            
            if (isFullScreen) {
                // 放大尺寸
                self.imageViewAvatar.frame = CGRectMake(0, 0, 480, 320)
            }
            else {
                // 缩小尺寸
                self.imageViewAvatar.frame = CGRectMake(100, 100, 128, 128)
            }
            // commit动画
            UIView.commitAnimations()
        }
    }
    }