//
//  NewsfeedCellLayoutCalculator.swift
//  VKp
//
//  Created by  Sergei on 28.04.2021.
//

import UIKit

protocol NewsfeedCellLayoutCalculatorDelegate: AnyObject {
  func sizes(
    postText: String?,
    postAttachment: FeedCellPhotoAttachmentViewModel?
  ) -> FeedCellSizesViewModel
}

struct Constants {
  static let cardInsets = UIEdgeInsets(top: 0, left: 6, bottom: 8, right: 6)
  static let topInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
  static let topHeight: CGFloat = 50
  static let postInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
  static let postFont = UIFont.systemFont(ofSize: 15)
  static let attachmentInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
  static let bottomHeight: CGFloat = 40
}

final class NewsfeedCellLayoutCalculator {
  private let screenWidth: CGFloat

  init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
    self.screenWidth = screenWidth
  }
}

extension NewsfeedCellLayoutCalculator: NewsfeedCellLayoutCalculatorDelegate {
  func sizes(
    postText: String?,
    postAttachment: FeedCellPhotoAttachmentViewModel?
  ) -> FeedCellSizesViewModel {
    let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right

    var postLabelFrame = CGRect(
      origin: CGPoint(
        x: Constants.postInsets.left,
        y: Constants.cardInsets.top + Constants.topInsets.top + Constants.topHeight),
      size: CGSize.zero)
    if let postText = postText, !postText.isEmpty {
      let width = cardViewWidth - Constants.postInsets.right - Constants.postInsets.left
      let height = postText.height(width: width, font: Constants.postFont)
      postLabelFrame.origin.y += Constants.postInsets.top
      postLabelFrame.size = CGSize(width: width, height: height)
    }

    var attachmentFrame = CGRect(
      origin: CGPoint(
        x: 0,
        y: postLabelFrame.maxY),
      size: CGSize.zero)
    if let postAttachment = postAttachment, postAttachment.height > 0, postAttachment.width > 0 {
      let width = cardViewWidth
      let ratio = width / CGFloat(postAttachment.width)
      let height = ceil(CGFloat(postAttachment.height) * ratio)
      attachmentFrame.origin.y += Constants.attachmentInsets.top
      attachmentFrame.size = CGSize(width: width, height: height)
    }

    let bottomView = CGRect(
      origin: CGPoint(
        x: 0,
        y: attachmentFrame.maxY),
      size: CGSize(
        width: cardViewWidth,
        height: Constants.bottomHeight))

    let viewHeight = bottomView.maxY + Constants.cardInsets.bottom

    return FeedViewModel.FeedCellSizes(
      postLabelFrame: postLabelFrame,
      attachmentFrame: attachmentFrame,
      bottomView: bottomView,
      viewHeight: viewHeight)
  }
}
