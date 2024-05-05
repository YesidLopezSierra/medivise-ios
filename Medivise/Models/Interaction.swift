//
//  Interaction.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 28.04.24.
//

import Foundation

struct Interaction: Codable {
    var drugOne: String?
    var drugTwo: String?
    var severity: Severity?
    var description: String?
    var extendedDescription: String?

    enum CodingKeys: String, CodingKey {
        case drugOne = "medicine_a"
        case drugTwo = "medicine_b"
        case severity
        case description
        case extendedDescription = "extended_description"
    }
}

enum Severity: String, CaseIterable, Identifiable, Codable {
    case major = "Major"
    case moderate = "Moderate"
    case minor = "Minor"
    case noInformation = "No information available"

    var id: Self { self }
}
