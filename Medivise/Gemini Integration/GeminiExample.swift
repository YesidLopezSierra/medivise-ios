//
//  GeminiExample.swift
//  Medivise
//
//  Created by Sara Ortiz Drada on 27.03.24.
//

import GoogleGenerativeAI
import SwiftUI

struct GeminiExample: View {
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    @State var textInput = ""
    @State var aiResponse = "Hello! How can I help you today?"
    
    var body: some View {
        HStack {
            TextField("Enter a message", text: $textInput)
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.black)
            Button(action: sendMessage, label: {
                Image(systemName: "paperplane.fill")
            })
        }
    }

    func sendMessage() {
        aiResponse = ""
        Task {
            do {
                let response = try await model.generateContent(textInput)

                guard let text = response.text else  {
                    textInput = "Sorry, I could not process that.\nPlease try again."
                    return
                }

                textInput = ""
                aiResponse = text
//                print(aiResponse)
            } catch {
                aiResponse = "Something went wrong!\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    GeminiExample()
}
