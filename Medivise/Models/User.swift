//
//  User.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 06.04.24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String?
    var age: Int
    var allergies: [String]
    var bloodType: BloodType
    var gender: Gender
    var height: Double
    var medicalConditions: [String]
    var name: String
    var weight: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case age
        case allergies
        case bloodType = "blood_type"
        case gender
        case height
        case medicalConditions = "medical_conditions"
        case name
        case weight
    }
}
