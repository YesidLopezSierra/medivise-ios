//
//  FoodInteraction.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 01.05.24.
//

import Foundation

struct FoodInteraction: Identifiable, Decodable {
    var id: UUID? = UUID()
    var name: String
    var description: String

}
