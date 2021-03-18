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
            
                       
            userImage.layer.cornerRadius = userImage.frame.height/2
            
            self.userImage.image = (viewModel.image != nil) ? UIImage(data: viewModel.image!) :UIImage(named: "chica")
            
            userImage.alpha = 0
           
            userImage.backgroundColor = UIColor(named: "tangerine")
            topicTitle.text = viewModel.textLabelText
            postCount.text = String(viewModel.topic.postsCount)
            numOfPost.text = String(viewModel.topic.highestPostNumber)
            //hay que darle formato a esta fecha
            var fechaFinal = dateFormatter(dateString: viewModel.topic.lastPostedAt)
            lastPostAt.text = String(fechaFinal)
            
            //se anima la aparicion de la imagen
            UIView.animate(withDuration: 3) { [weak self] in
                guard let self = self else {return}
                self.userImage.alpha = 1
            } completion: {[weak self] (finished) in
                /*
                 esta parte no es necesaria en este caso, pero recuerda que se puede hacer
                 otra animación o ejecutar cualquier orden al termar la animación anterior
                 */
                guard let self = self else {return}
                
                self.userImage.alpha = 1
            }

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
        //userImage?.image = viewModel?.image
        setNeedsLayout()
    }
}
