//
//  UserRepository.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 06.04.24.
//

import Foundation

class UserRepository {
    private let userService: UserServiceProtocol

    init(service: UserServiceProtocol) {
        self.userService = service
    }

    func saveHealthDetailsFor(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        userService.saveHealthDetailsFor(user: user, completion: completion)
    }
}
