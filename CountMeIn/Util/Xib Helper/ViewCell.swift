//
//  ViewCell.swift
//  Wao
//
//  Created by zhaochenjun on 16/1/9.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit

@IBDesignable
class ViewCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup(){
        
        let topLine = UIView(frame: CGRectMake(0, 0, ScreenWidth, px1))
        let bottomLine = UIView(frame: CGRectMake(0, self.frame.height - px1, ScreenWidth, px1))
        
        topLine.backgroundColor = rgba(220, g: 220, b: 220, a: 1)
        bottomLine.backgroundColor = rgba(220, g: 220, b: 220, a: 1)
        
        self.addSubview(topLine)
        self.addSubview(bottomLine)
        
    }
    
}
