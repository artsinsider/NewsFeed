//
//  NewsFeedCell.swift
//  NewsFeed_v2
//
//  Created by Egor on 17.06.2020.
//  Copyright © 2020 TASS. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shared: String? { get }
    var views : String? { get }
}

class NewsFeedCell: UITableViewCell {
    
    static let reuserId = "NewsFeedCell"
    
    
    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var NameLable: UILabel!
    @IBOutlet weak var DateLable: UILabel!
    @IBOutlet weak var postLable: UILabel!
    @IBOutlet weak var likesLable: UILabel!
    @IBOutlet weak var commentsLable: UILabel!
    @IBOutlet weak var eyeLable: UILabel!
    @IBOutlet weak var repostLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: FeedCellViewModel) {
        NameLable.text = viewModel.name
        DateLable.text = viewModel.date
        postLable.text = viewModel.text
        likesLable.text = viewModel.likes
        commentsLable.text = viewModel.comments
        eyeLable.text = viewModel.views
        repostLable.text = viewModel.shared
        
    }
}
