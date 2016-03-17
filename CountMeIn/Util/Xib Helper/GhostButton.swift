//
//  GhostButton.swift
//  Wao
//
//  Created by zhaochenjun on 16/1/10.
//  Copyright © 2016年 kazmastudio. All rights reserved.
//

import UIKit

@IBDesignable

class GhostButton: UIButton {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    var oBorderColor = rgba(0, g: 0, b: 0, a: 0)
    var oTextColor = rgba(0, g: 0, b: 0, a: 0)
    
    var bLighter = false
    
    @IBInspectable override var borderColor: UIColor {
        
        get {
            
            return UIColor(CGColor: layer.borderColor!)
            
        }
        
        set {
            
            layer.borderColor = newValue.CGColor
            self.oBorderColor = UIColor(CGColor: self.layer.borderColor!)
            
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
        self.oTextColor = (self.titleLabel?.textColor)!
        
    }
    
    func touchDown(){
        
        UIView.transitionWithView(self, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            
            if(self.bLighter){
                
                self.layer.borderColor = self.lighterColor(self.oBorderColor).CGColor
                self.setTitleColor(self.lighterColor(self.oTextColor), forState: UIControlState.Normal)
                
                self.imageView?.alpha = 0.5
                
            }else{
                
                self.layer.borderColor = self.darkerColor(self.oBorderColor).CGColor
                self.setTitleColor(self.darkerColor(self.oTextColor), forState: UIControlState.Normal)
                
            }
            
            
            }, completion: {finished in
                
                if(self.bLighter){
                    
                    self.layer.borderColor = self.lighterColor(self.oBorderColor).CGColor
                    self.setTitleColor(self.lighterColor(self.oTextColor), forState: UIControlState.Normal)
                    
                    self.imageView?.alpha = 0.5
                    
                }else{
                    
                    self.layer.borderColor = self.darkerColor(self.oBorderColor).CGColor
                    self.setTitleColor(self.darkerColor(self.oTextColor), forState: UIControlState.Normal)
                    
                }
                
        })
        
    }
    
    func touchUp() {
        
        UIView.transitionWithView(self, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            
            self.layer.borderColor = self.oBorderColor.CGColor
            self.setTitleColor(self.oTextColor, forState: UIControlState.Normal)
            
            self.imageView?.alpha = 1
            
            }, completion:{finished in
                
                self.layer.borderColor = self.oBorderColor.CGColor
                self.setTitleColor(self.oTextColor, forState: UIControlState.Normal)
                
                self.imageView?.alpha = 1
                
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
