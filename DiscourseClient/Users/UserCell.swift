//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Jorge Sanchez on 15/03/2021.
//  
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            userImage.layer.cornerRadius = 40
            userImage.image = viewModel.userImage
            userName.text = viewModel.textLabelText
        }
    }
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        userImage?.image = viewModel?.userImage
        setNeedsLayout()
    }
}
