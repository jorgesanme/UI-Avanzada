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
            userImage.alpha = 0
            // se anima la aparición de la imagen
            UIView.animate(withDuration: 3.0) { [weak self] in
                guard let self = self else {return}
                
                self.userImage.alpha = 1
                
            } completion: { [weak self] (finished) in
                /*
                 esta parte no es necesaria en este caso, pero recuerda que se puede hacer
                 otra animación o ejecutar cualquier orden al termar la animación anterior
                 */
                guard let self = self else  {return}
                self.userImage.alpha = 1
            }

        }
    }
    
}



extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        userImage?.image = viewModel?.userImage
        setNeedsLayout()
    }
}
