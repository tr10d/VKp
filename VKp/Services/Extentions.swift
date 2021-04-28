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
