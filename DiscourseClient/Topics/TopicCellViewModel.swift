//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

//protocolo para avisar de la recepcion del avatar
protocol TopicCellViewModelDelegate {
    func imageDidFetched()
}

/// ViewModel que representa un topic en la lista
class TopicCellViewModel {
    var cellViewModelDelegate : TopicCellViewModelDelegate?
    let topic: Topic
    var textLabelText: String?
    var image: Data?
    
    init(topic: Topic,users: [User], dataManager: TopicsDataManager) {
        self.topic = topic
        textLabelText = topic.title
        
        users.forEach { (user) in
            if topic.lastPosterUsername == user.username{
                dataManager.fechtUserImage(userURLTemplate: user.avatarTemplate) { (data) in
                    self.image = data
                    self.cellViewModelDelegate?.imageDidFetched()
                }
            }
        }
    }
}
