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
}

protocol FeedCellPhotoAttachmentViewModel {
  var url: String? { get }
  var width: Int { get }
  var height: Int { get }
}

class NewsfeedCell: UITableViewCell {
  static let reuseId = "NewsfeedCell"
  static let nib = UINib(nibName: "NewsfeedCell", bundle: nil)

  @IBOutlet weak var avatarImageView: WebImageView!
  @IBOutlet weak var avatarNameLabel: UILabel!
  @IBOutlet weak var avatarDateLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  @IBOutlet weak var postImageView: WebImageView!
  @IBOutlet weak var heartLabel: UILabel!
  @IBOutlet weak var bubbleLabel: UILabel!
  @IBOutlet weak var arrowLabel: UILabel!
  @IBOutlet weak var eyeLabel: UILabel!

  override class func awakeFromNib() {
    super.awakeFromNib()
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
  }
}
