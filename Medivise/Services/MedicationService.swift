//
//  MedicationService.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 05.04.24.
//

import Foundation

protocol MedicationServiceProtocol {
    func fetchMedications(for userId: String, completion: @escaping (Result<[Medication], Error>) -> Void)
    func saveMedication(medication: Medication, completion: @escaping (Result<String, Error>) -> Void)
}

class MedicationService: MedicationServiceProtocol {
    func fetchMedications(for userId: String, completion: @escaping (Result<[Medication], Error>) -> Void) {
        let urlString = "http://34.29.156.157/user/\(userId)/medications"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")

        print(url)

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "InvalidResponse", code: -1, userInfo: nil)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
                return
            }

            do {
                let medications = try JSONDecoder().decode([Medication].self, from: data)
                completion(.success(medications))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func saveMedication(medication: Medication, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://34.29.156.157/medications") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let jsonData = try JSONEncoder().encode([medication])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(URLError(.cannotParseResponse)))
            }
        }
        if let json = String(data: request.httpBody!, encoding: .utf8) {
            print("Request JSON: \(json)")
        }
        
        task.resume()
    }
}
