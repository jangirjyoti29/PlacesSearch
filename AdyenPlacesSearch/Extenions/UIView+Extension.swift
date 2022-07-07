//
//  UIView+Extension.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import UIKit

extension UIView {
    func centerAnchors(centerX:NSLayoutXAxisAnchor?, centerXConstant:CGFloat = 0, centerY:NSLayoutYAxisAnchor?, centerYConstant:CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant).isActive = true
        }
    }
    
    func anchor(top:NSLayoutYAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, leading:NSLayoutXAxisAnchor? = nil, trailing:NSLayoutXAxisAnchor? = nil, topConstant:CGFloat = 0, bottomConstant:CGFloat = 0, leadingConstant:CGFloat = 0, trailingConstant:CGFloat = 0, heightConstant:CGFloat? = nil, heightGreater:Bool? = nil, widthConstant:CGFloat? = nil, widthGreater:Bool? = nil){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingConstant).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant).isActive = true
        }
        
        if let width = widthConstant{
            if let widthGreater = widthGreater, widthGreater == true {
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
            }else{
                self.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
        
        if let height = heightConstant{
            if let heightGreater = heightGreater, heightGreater == true {
                self.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
            }else{
                self.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
}

extension UIView {
    func shadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = ADColor.black.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.30
        self.layer.masksToBounds = false
    }
}
