//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Jorge Sanchez on 15/03/2021.
//  
//

import UIKit

protocol UserCellViewModelViewDelegate: class {
    func userImageFetched()
}

class UserCellViewModel {
    weak var viewDelegate: UserCellViewModelViewDelegate?
    let user: User
    let textLabelText: String?
    var userImage: UIImage?
    
    init(user: User) {
        self.user = user

        textLabelText = user.name ?? "¡Sin Nombre!"

        var imageStringURL = "https://mdiscourse.keepcoding.io"
        imageStringURL.append(user.avatarTemplate.replacingOccurrences(of: "{size}", with: "100"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: imageStringURL), let data = try? Data(contentsOf: url) {
                self?.userImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.viewDelegate?.userImageFetched()
                }
            }
        }
    }
}
