//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var topicTitle: UILabel!
    
    @IBOutlet weak var postCount: UILabel! //contador de comentarios
    @IBOutlet weak var lastPostAt: UILabel! //fecha
    @IBOutlet weak var numOfPost: UILabel! //numero de personas que han comentado
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
                       
            userImage.layer.cornerRadius = 32 //userImage.frame.height/2
            userImage.image = UIImage(named: "AppIcon")
            userImage.backgroundColor = .brown
            topicTitle.text = viewModel.textLabelText
            postCount.text = String(viewModel.topic.postsCount)
            numOfPost.text = String(viewModel.topic.highestPostNumber)
            //hay que darle formato a esta fecha
            var fechaFinal = dateFormatter(dateString: viewModel.topic.lastPostedAt)
            lastPostAt.text = String(fechaFinal)
        }
    }
    
    func dateFormatter(dateString: String) -> String {
        //dado que no se va ha usar en otro lugar, lo he dejado aquí
        let inputStringDate = dateString //Este es el String que nos llega
        let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ" // este es el formato que tiene la cadena
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = inputFormat
        
        guard let date = dateFormatter.date(from: inputStringDate) else {return ""}
     
        let outputFormat = "MMM d"
        dateFormatter.dateFormat = outputFormat
        let ouputStringDate = dateFormatter.string(from: date)
        return ouputStringDate
    }
}
extension TopicCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        //userImage?.image = viewModel?.userImage
        userImage?.image = UIImage(named: "AppIcon")
        setNeedsLayout()
    }
}
