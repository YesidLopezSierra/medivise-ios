//
//  DDICheckerService.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.04.24.
//

import Foundation
protocol DDICheckerServiceProtocol {
    func checkInteractionBetween(drugOne: String, drugTwo: String,  completion: @escaping (Result<Interaction, Error>) -> Void)
    func fetchFoodInteractions(for medicine: String, completion: @escaping (Result<[FoodInteraction], Error>) -> Void)
}

class DDICheckerService: DDICheckerServiceProtocol {
    private let baseURLString = "http://34.29.156.157/interactions/medication"

    func checkInteractionBetween(drugOne: String, drugTwo: String, completion: @escaping (Result<Interaction, Error>) -> Void) {
        guard var components = URLComponents(string: baseURLString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        components.queryItems = [
            URLQueryItem(name: "medicine_a", value: drugOne),
            URLQueryItem(name: "medicine_b", value: drugTwo)
        ]

        guard let url = components.url else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.cannotParseResponse)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let interaction = try decoder.decode(Interaction.self, from: data)
                completion(.success(interaction))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func fetchFoodInteractions(for medicine: String, completion: @escaping (Result<[FoodInteraction], Error>) -> Void) {
        guard let url = URL(string: "http://34.29.156.157/interactions/food?medicine=\(medicine)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                print(data)
                let interactions = try JSONDecoder().decode([FoodInteraction].self, from: data)
                completion(.success(interactions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

