//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            
            userImage.image = viewModel.userImage
            userName.text = viewModel.textLabelText
            
//            textLabel?.text = viewModel.textLabelText
//            imageView?.image = viewModel.userImage
        }
    }
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        userImage?.image = viewModel?.userImage
        setNeedsLayout()
    }
}