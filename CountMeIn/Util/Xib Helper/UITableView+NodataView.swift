//
//  UITableView+NodataView.swift
//  Wao
//
//  Created by zhaochenjun on 16/1/18.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit

extension UITableView{
    
    func addNodataView(title: String, imageName: String, offsetY: CGFloat){
        
        if let view: UIView = self.viewWithTag(TABLE_VIEW_NO_DATA_VIEW_TAG){
            
            view.removeFromSuperview()
            
        }
        
        var offsetHeight: CGFloat
        
        offsetHeight  = (self.frame.size.height - ScreenHeight/3)/2
        
        if (offsetY > 0){
            
            offsetHeight = offsetY
            
        }
        
        let noDataView = UIView.init(frame: CGRectMake(0, offsetHeight, ScreenWidth, ScreenHeight/3))
        
        noDataView.tag = TABLE_VIEW_NO_DATA_VIEW_TAG
        
        let imageView = UIImageView.init(frame: CGRectMake((ScreenWidth - 80) / 2, (ScreenHeight/3 - 134) / 2, 80, 80))

        if !imageName.isEmpty || imageName != ""{
            imageView.image = UIImage.init(named: imageName)
        }
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        noDataView.addSubview(imageView)
        
        let label = UILabel.init(frame: CGRectMake(0, (ScreenHeight/3 - 134)/2 + 110, ScreenWidth, 24))
        label.font = UIFont.systemFontOfSize(24)
        label.textColor = rgba(200, g: 200, b: 200, a: 1)
        label.textAlignment = NSTextAlignment.Center
        
        noDataView.addSubview(label)
        
        self.addSubview(noDataView)
        
    }
    
    func hideNoDataView(){
     
        self.viewWithTag(TABLE_VIEW_NO_DATA_VIEW_TAG)?.removeFromSuperview()
        
    }
    
}
