//
//  BloodType.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 06.04.24.
//

import Foundation

enum BloodType: String, CaseIterable, Identifiable, Codable {
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    case oPositive = "O+"
    case oNegative = "O-"

    var id: Self { self }
}

enum Gender: String, CaseIterable, Identifiable, Codable {
    case female = "Female"
    case male = "Male"
    case other = "Other"

    var id: Self { self }
}
