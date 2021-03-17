//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewModel que representa un topic en la lista
class TopicCellViewModel {
    let topic: Topic
    var textLabelText: String?
    var image: UIImage?
    
    init(topic: Topic, dataManager: TopicsDataManager) {
        self.topic = topic
        textLabelText = topic.title
        
        dataManager.fechtUserImage(userName: topic.lastPosterUsername) { [weak self](image) in
            self?.image = image
        }
    }
}
