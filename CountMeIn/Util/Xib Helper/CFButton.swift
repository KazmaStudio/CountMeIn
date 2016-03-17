//
//  CFButton.swift
//  Wao
//
//  Created by zhaochenjun on 16/1/11.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit

class CFButton: UIButton {

    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    var oBackgroundColor = rgba(0, g: 0, b: 0, a: 0)
    
    var bLighter = false
    
    @IBInspectable var bgColor: UIColor {
        
        get {
            
            return self.backgroundColor!
            
        }
        
        set {
        
            self.oBackgroundColor = newValue
            
        }
        
    }
    
    @IBInspectable var lighter: Bool {
        
        get {
            
            return self.bLighter
            
        }
        
        set {
            
            self.bLighter = newValue
            
        }
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.setup()
        
    }
    
    override var highlighted: Bool {
        
        willSet(newValue) {
            
            if(newValue && !highlighted){
                
                self.touchDown()
                
            }
            
            if(!newValue){
                
                self.touchUp()
                
            }
            
        }
        
    }
    
    func setup(){
        
        self.clipsToBounds = true
        
    }
    
    func touchDown(){
        
        UIView.animateWithDuration(0.3, animations:{
            
            if(self.bLighter){
                
                self.backgroundColor = self.lighterColor(self.oBackgroundColor)
                
            }else{
                
                self.backgroundColor = self.darkerColor(self.oBackgroundColor)
                
            }
            
            
            }, completion: {finished in
                
                if(self.bLighter){
                    
                    self.backgroundColor = self.lighterColor(self.oBackgroundColor)
                    
                }else{
                    
                    self.backgroundColor = self.darkerColor(self.oBackgroundColor)
                    
                }
                
        })
        
    }
    
    func touchUp() {
        
        UIView.animateWithDuration(0.3, animations:{
            
            self.backgroundColor = self.oBackgroundColor
            
            
            }, completion: {finished in
                
                self.backgroundColor = self.oBackgroundColor
                
        })
        
    }
    
    func lighterColor(color: UIColor) -> UIColor{
        
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
            
            return UIColor.init(hue: hue, saturation: max(saturation - 0.3, 0.0), brightness: min(brightness * 1.3, 1.0), alpha: alpha * 0.5)
            
        }
        
        return rgba(0, g: 0, b: 0, a: 1)
    }
    
    func darkerColor(color: UIColor) -> UIColor{
        
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
            
            return UIColor.init(hue: hue, saturation: saturation, brightness: brightness * 0.75, alpha: alpha)
            
        }
        
        return rgba(0, g: 0, b: 0, a: 1)
        
    }

}
