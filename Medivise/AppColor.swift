//
//  AppColor.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 05.04.24.
//

import Foundation
import SwiftUI

public enum AppColor {
    case blue
    case lightblue
    case darkblue
    case green
    case lightgreen
    case darkgreen
    case darkpurple

    var color: Color {
        switch self {
        case .blue:
            return Color("blue")
        case .lightblue:
            return Color("lightblue")
        case .darkblue:
            return Color("darkblue")
        case .green:
            return Color("green")
        case .lightgreen:
            return Color("ligthgreen")
        case .darkgreen:
            return Color("darkgreen")
        case .darkpurple:
            return Color("darkpurple")
        }
    }
}
