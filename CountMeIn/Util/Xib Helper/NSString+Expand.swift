//
//  NSString+Expand.swift
//  Wao
//
//  Created by 华瑞金科 on 16/1/31.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit

extension NSString{

    
    func getSizeWithConstraint(Constraint:CGSize , font:UIFont) -> CGFloat{
    
        return self.boundingRectWithSize(Constraint, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:[NSFontAttributeName: font], context: nil).width + 50
        
    
    }
    
}
