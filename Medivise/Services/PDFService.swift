//
//  MedicationPDFService.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 29.04.24.
//

import Foundation

protocol MedicationPDFServiceProtocol {
    func downloadPDF(for userID: String, completion: @escaping (Result<URL, Error>) -> Void)
}

class MedicationPDFService: MedicationPDFServiceProtocol {

    func downloadPDF(for userID: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let urlString = "http://34.29.156.157/user/\(userID)/medications/pdf"
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let fileManager = FileManager.default
                let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsPath.appendingPathComponent("\(userID)-medication.pdf")

                try data.write(to: fileURL)
                completion(.success(fileURL))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
