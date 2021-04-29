//
//  NewsfeedCellCode.swift
//  VKp
//
//  Created by  Sergei on 29.04.2021.
//

import UIKit

final class NewsfeedCellCode: UITableViewCell {
  static let reuseId = "NewsfeedCellCode"

  let cardView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9251194596, green: 0.8710257411, blue: 0.6354646683, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NewsfeedCellCode {
  fileprivate func configure() {
    addSubview(cardView)
    
    //    cardView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    //    cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
    //    cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    //    cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    
    //    cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    //    cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    //    cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    //    cardView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
    //        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
    //        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    //    cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    //    cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    cardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    cardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2) .isActive = true

    backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
  }
}
