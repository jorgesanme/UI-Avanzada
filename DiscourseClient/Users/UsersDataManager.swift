//
//  UsersDataManager.swift
//  DiscourseClient
//
//  Created by Jorge Sanchez on 15/03/2021.
//

import Foundation

protocol UsersDataManager: class {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
}
