//
//  NewsfeedViewController.swift
//  NewsFeed_v2
//
//  Created by Egor on 17.06.2020.
//  Copyright (c) 2020 TASS. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {

  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?

    private var feedViewModel =  FeedViewModel.init(cells: [])

    @IBOutlet weak var Table: UITableView!
    
  // MARK: Setup
  
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
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
//    Table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    Table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuserId)
    interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsFeed)
  }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    
    case .displayNewsFeed(let feedViewModel):
        self.feedViewModel = feedViewModel
        Table.reloadData()
    }
  }
}


extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuserId, for: indexPath) as! NewsFeedCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("select row \(indexPath.row)")
//        interactor?.makeRequest(request: .getFeed)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    
}
