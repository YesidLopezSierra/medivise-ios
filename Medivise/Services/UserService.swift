//
//  UserService.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 06.04.24.
//

import Foundation

protocol UserServiceProtocol {
    func saveHealthDetailsFor(user: User, completion: @escaping (Result<User, Error>) -> Void)
}

class UserService: UserServiceProtocol {
    private let baseURLString = "http://34.29.156.157/health-details"

    func saveHealthDetailsFor(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: baseURLString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = createURLRequest(url: url)

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                completion(.failure(URLError(.cannotParseResponse)))
                return
            }

            self.handleResponse(httpResponse: httpResponse, data: data, completion: completion)
        }.resume()
    }

    private func createURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 60
        return request
    }

    private func handleResponse(httpResponse: HTTPURLResponse, data: Data, completion: @escaping (Result<User, Error>) -> Void) {
        switch httpResponse.statusCode {
        case 200...299:
            do {
                let responseString = String(data: data, encoding: .utf8)
                print("Received JSON string: \(responseString ?? "Invalid data")")
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        case 422:
            do {
                let responseString = String(data: data, encoding: .utf8)
                print("Received JSON string: \(responseString ?? "Invalid data")")
                let validationError = try JSONDecoder().decode(ValidationError.self, from: data)
                completion(.failure(validationError))
            } catch {
                completion(.failure(error))
            }
        default:
            let serverErrorMessage = String(data: data, encoding: .utf8) ?? "Unknown server error"
            print("Server Error: \(serverErrorMessage)")
            completion(.failure(URLError(.badServerResponse)))
        }
    }
}

struct ValidationError: Error, Decodable {
    let detail: [ErrorDetail]
}

struct ErrorDetail: Decodable {
    let loc: [String]
    let msg: String
    let type: String
}
