//
//  NewsfeedCell.swift
//  VKp
//
//  Created by  Sergei on 27.04.2021.
//

import UIKit

protocol FeedCellViewModel {
  var image: String { get }
  var name: String { get }
  var date: String { get }
  var text: String? { get }
  var likes: String? { get }
  var comments: String? { get }
  var shares: String? { get }
  var views: String? { get }
  var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
  var sizes: FeedCellSizesViewModel { get }
}

protocol FeedCellPhotoAttachmentViewModel {
  var url: String? { get }
  var width: Int { get }
  var height: Int { get }
}

protocol FeedCellSizesViewModel {
  var postLabelFrame: CGRect { get }
  var attachmentFrame: CGRect { get }
  var bottomView: CGRect { get }
  var viewHeight: CGFloat { get }
}

class NewsfeedCell: UITableViewCell {
  static let reuseId = "NewsfeedCell"
  static let nib = UINib(nibName: "NewsfeedCell", bundle: nil)

  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var avatarImageView: WebImageView!
  @IBOutlet weak var avatarNameLabel: UILabel!
  @IBOutlet weak var avatarDateLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  @IBOutlet weak var postImageView: WebImageView!
  @IBOutlet weak var heartLabel: UILabel!
  @IBOutlet weak var bubbleLabel: UILabel!
  @IBOutlet weak var arrowLabel: UILabel!
  @IBOutlet weak var eyeLabel: UILabel!

  @IBOutlet weak var bottomView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
}

extension NewsfeedCell {
  func configure() {
    cardView.layer.cornerRadius = 10
    cardView.clipsToBounds = true

    avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    avatarImageView.clipsToBounds = true

    backgroundColor = .clear
    selectionStyle = .none
  }

  func set(viewModel: FeedCellViewModel) {
    avatarImageView.set(imageURL: viewModel.image)
    avatarNameLabel.text = viewModel.name
    avatarDateLabel.text = viewModel.date
    postLabel.text = viewModel.text
    postImageView.set(imageURL: viewModel.photoAttachment?.url)
    heartLabel.text = viewModel.likes
    bubbleLabel.text = viewModel.comments
    arrowLabel.text = viewModel.shares
    eyeLabel.text = viewModel.views

    postLabel.frame = viewModel.sizes.postLabelFrame
    postImageView.frame = viewModel.sizes.attachmentFrame
    bottomView.frame = viewModel.sizes.bottomView
  }
}
