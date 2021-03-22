//
//  WellcomeViewModel.swift
//  DiscourseClient
//
//  Created by Jorge Sanchez on 19/03/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

class WellcomeViewModel: CellViewModel{
    var type: TypeOfCell
    
    init(cellType: TypeOfCell){
        self.type = cellType        
    }
    
    
}
