//
//  Extentions.swift
//  VKp
//
//  Created by  Sergei on 28.04.2021.
//

import UIKit

extension String {
  func height(width: CGFloat, font: UIFont) -> CGFloat {
    let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
    let size = self.boundingRect(
      with: textSize,
      options: .usesLineFragmentOrigin,
      attributes: [.font: font],
      context: nil)
    return ceil(size.height)
  }
}

extension UIView {
  func fillSuperview(padding: UIEdgeInsets) {
    anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
  }
  
  func fillSuperview() {
    fillSuperview(padding: .zero)
  }
  
  func anchorSize(to view: UIView) {
    widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
  }
  
  func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
    }
    
    if let leading = leading {
      leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
    }
    
    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
    }
    
    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
  }
}
