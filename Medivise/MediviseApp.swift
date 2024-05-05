//
//  MediviseApp.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 26.03.24.
//

import SwiftUI

@main
struct MediviseApp: App {
    var body: some Scene {
        let userFormViewModel = UserFormViewModel()
        let medicationViewModel = MedicationViewModel()

        WindowGroup {
            HomePage()
                .environmentObject(userFormViewModel)
                .environmentObject(medicationViewModel)
        }
    }
}
