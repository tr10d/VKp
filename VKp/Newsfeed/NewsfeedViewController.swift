//
//  NewsfeedViewController.swift
//  VKp
//
//  Created by  Sergei on 26.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: AnyObject {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController {
  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?

  private var feedViewModel = FeedViewModel(cells: [])

  @IBOutlet weak var table: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    viewDidLoadDataSource()
    viewDidLoadRouting()
  }
}

// MARK: Setup

extension NewsfeedViewController {
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
}

// MARK: Data Source

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
  func viewDidLoadDataSource() {
    table.register(NewsfeedCell.nib, forCellReuseIdentifier: NewsfeedCell.reuseId)
    table.register(NewsfeedCellCode.self, forCellReuseIdentifier: NewsfeedCellCode.reuseId)
    table.separatorStyle = .none
    table.backgroundColor = .clear

    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    feedViewModel.cells.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    200 //feedViewModel.cells[indexPath.row].sizes.viewHeight
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView
//            .dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as? NewsfeedCell
//      else { fatalError("Unresolved dequeueReusableCell error") }
    guard let cell = tableView
            .dequeueReusableCell(withIdentifier: NewsfeedCellCode.reuseId, for: indexPath) as? NewsfeedCellCode
      else { fatalError("Unresolved dequeueReusableCell error") }
    let viewModel = feedViewModel.cells[indexPath.row]
    cell.textLabel?.text = viewModel.text
//   cell.set(viewModel: feedViewModel.cells[indexPath.row])
    return cell
  }
}

// MARK: Routing

extension NewsfeedViewController {
  func viewDidLoadRouting() {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    table.refreshControl = refreshControl

    interactor?.makeRequest(request: .newsFeed)
  }

  @objc func refresh(_ sender: AnyObject) {
    interactor?.makeRequest(request: .newsFeed)
  }
}

extension NewsfeedViewController: NewsfeedDisplayLogic {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .newsFeed(let viewModel):
      feedViewModel = viewModel
      table.refreshControl?.endRefreshing()
      table.reloadData()
    }
  }
}
