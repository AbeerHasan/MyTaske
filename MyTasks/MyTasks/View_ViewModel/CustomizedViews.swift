//
//  UINavigationController Ext.swift
//  MyTasks
//
//  Created by Abeer Abbas Saber on 11/29/20.
//  Copyright © 2020 Abeer Abbas Saber. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView{

//---Attributes Appearse on the proprities-----
@IBInspectable
var cornerRadius : CGFloat = 20.0 {
    didSet {
        self.layer.cornerRadius = cornerRadius
    }
}
@IBInspectable
var shadowOpacity : CGFloat = 1 {
    didSet {
        self.layer.shadowOpacity = Float(shadowOpacity)
    }
}
@IBInspectable
var shadowRadius : CGFloat = 1.7  {
    didSet {
       self.layer.shadowRadius = shadowRadius
    }
}
//---------------------------------------------

override func awakeFromNib() { // to make the design appears at run time
    super.awakeFromNib()
    self.setUpView()
}
override func prepareForInterfaceBuilder() { // to make the design appears on the storyboard
    super.prepareForInterfaceBuilder()
    self.setUpView()
}

//----------------------------------------------
func setUpView(){
    let sceenWidth = UIScreen.main.bounds.width
    if sceenWidth >= 568 {
        self.layer.cornerRadius = cornerRadius * 2.5
    }else {
        self.layer.cornerRadius = cornerRadius
    }
    self.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    self.layer.shadowOffset = CGSize(width: 0, height: 2)
}
}

class RoundedView: UIVisualEffectView{

//---Attributes Appearse on the proprities-----
@IBInspectable
var cornerRadius : CGFloat = 20.0 {
    didSet {
        self.layer.cornerRadius = cornerRadius
    }
}
@IBInspectable
var shadowOpacity : CGFloat = 1 {
    didSet {
        self.layer.shadowOpacity = Float(shadowOpacity)
    }
}
@IBInspectable
var shadowRadius : CGFloat = 1.7  {
    didSet {
       self.layer.shadowRadius = shadowRadius
    }
}
//---------------------------------------------

override func awakeFromNib() { // to make the design appears at run time
    super.awakeFromNib()
    self.setUpView()
}
override func prepareForInterfaceBuilder() { // to make the design appears on the storyboard
    super.prepareForInterfaceBuilder()
    self.setUpView()
}

//----------------------------------------------
func setUpView(){
    let sceenWidth = UIScreen.main.bounds.width
    if sceenWidth >= 568 {
        self.layer.cornerRadius = cornerRadius * 2.5
    }else {
        self.layer.cornerRadius = cornerRadius
    }
    self.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
}
}
