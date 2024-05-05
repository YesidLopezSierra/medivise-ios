//
//  Medication.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 27.03.24.
//

import Foundation

struct Medication: Codable, Identifiable {
    var id: String?
    var brandName: String?
    var genericName: String?
    var type: String?
    var strength: Double?
    var unit: String?
    var purpose: String?
    var frequency: [String]?
    var notes: String?
    var userId: String? 

    enum CodingKeys: String, CodingKey {
        case brandName = "brand_name"
        case genericName = "generic_name"
        case type
        case strength
        case unit
        case purpose
        case notes
        case frequency
        case userId = "user_id"
        case id = "_id"
    }
}

struct MedicineDetails: Codable {
    var brandName: String?
    var genericName: String?
    var type: String?
    var strength: Double?
    var unit: String?
    var purpose: String?

    enum CodingKeys: String, CodingKey {
        case brandName = "brand_name"
        case genericName = "generic_name"
        case type
        case strength
        case unit
        case purpose
    }
}

extension Medication {
    static let sampleData: [Medication] = [
        Medication(
            id: "6616a1d004c2d4b6267b8654",
            brandName: "Care",
            genericName: "Paracetamol",
            type: "Pill",
            strength: 350.0,
            unit: "mg",
            purpose: "Pain Reliever",
            frequency: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
            notes: "",
            userId: "6616997f04c2d4b6267b8652"
        ),
        Medication(
            id: "6616a1d005c2d4b6267b8654",
            brandName: "Amazon Care",
            genericName: "Tylenol",
            type: "Pill",
            strength: 24.0,
            unit: "mg",
            purpose: "Pain Reliever",
            frequency: ["Monday", "Wednesday", "Friday", "Saturday"],
            notes: "",
            userId: "6616997f04c2d4b6267b8652"
        ),
        Medication(
            id: "6616aa9704c2d4b6267b8656",
            brandName: "Amazon Basic Care",
            genericName: "Acetaminophen",
            type: "Tablet",
            strength: 500.0,
            unit: "mg",
            purpose: "Pain Reliever/Fever Reducer",
            frequency: ["Monday"],
            notes: "",
            userId: "6616997f04c2d4b6267b8652"
        ),
        Medication(
            id: "6616a1d004c2d4b6267b8653",
            brandName: "Care",
            genericName: "Paracetamol",
            type: "Pill",
            strength: 350.0,
            unit: "mg",
            purpose: "Pain Reliever",
            frequency: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
            notes: "",
            userId: "6616997f04c2d4b6267b8652"
        )
        ,
        Medication(
            id: "6616a1d005c2d4b6267c8654",
            brandName: "Amazon Care",
            genericName: "Tylenol",
            type: "Pill",
            strength: 24.0,
            unit: "mg",
            purpose: "Pain Reliever",
            frequency: ["Monday", "Wednesday", "Friday", "Saturday"],
            notes: "",
            userId: "6616997f04c2d4b6267b8652"
        ),
        Medication(
            id: "6616ba9704c2d4b6267b8656",
            brandName: "Amazon Basic Care",
            genericName: "Acetaminophen",
            type: "Tablet",
            strength: 500.0,
            unit: "mg",
            purpose: "Pain Reliever/Fever Reducer",
            frequency: ["Monday"],
            notes: "",
            userId: "6616997f04c2d4b6267b8652"
        )
    ]
}
