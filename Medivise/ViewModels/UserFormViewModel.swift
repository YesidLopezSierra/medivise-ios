//
//  UserFormViewModel.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 06.04.24.
//

import Foundation

class UserFormViewModel: ObservableObject {
    @Published var age: String = ""
    @Published var allergies: String = ""
    @Published var selectedBloodType: BloodType = .aPositive
    @Published var gender: Gender = .female
    @Published var height: String = ""
    @Published var medicalConditions: String = ""
    @Published var name: String = ""
    @Published var weight: String = ""
    @Published var isCreatingUser: Bool = false

    private let userRepository: UserRepository

    init() {
        self.userRepository = UserRepository(service: UserService())
    }

    func createUser() {
        isCreatingUser = true
        let user = User(age: Int(age) ?? 0,
                        allergies: allergies.components(separatedBy: ", "),
                        bloodType: selectedBloodType,
                        gender: gender,
                        height: Double(height) ?? 0.0,
                        medicalConditions: medicalConditions.components(separatedBy: ", "),
                        name: name,
                        weight: Double(weight) ?? 0.0)

        userRepository.saveHealthDetailsFor(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Success: \(user)")
                    self.saveUserId(user.id!)
                    self.saveUser(user)
                    self.clearForm()
                    self.isCreatingUser = false
                case .failure(let error):
                    print("Error saving medication: \(error.localizedDescription)")
                    self.clearForm()
                    self.isCreatingUser = false
                }
            }
        }
    }

    func getUserId() -> String? {
        return UserDefaults.standard.string(forKey: "userID")
    }

    private func saveUserId(_ userId: String) {
        UserDefaults.standard.set(userId, forKey: "userID")
    }

    func getUser() -> User? {
        let defaults = UserDefaults.standard
        if let userData = defaults.data(forKey: "user") {
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData)
                return user
            } catch {
                print("Failed to decode user: \(error)")
            }
        }
        return nil
    }

    func saveUser(_ user: User) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        do {
            let userData = try encoder.encode(user)
            defaults.set(userData, forKey: "user")
        } catch {
            print("Failed to encode user: \(error)")
        }
    }

    private func clearForm() {
        age = ""
        allergies = ""
        selectedBloodType = .aPositive
        gender = .female
        height = ""
        medicalConditions = ""
        weight = ""
    }
}
