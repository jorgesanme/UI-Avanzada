//
//  ImageUserProtocol.swift
//  DiscourseClient
//
//  Created by Jorge Sanchez on 17/03/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

protocol ImageUserProtocol {
    func fechtUserImage(userName: String, completion: @escaping (UIImage)->())
    
}
