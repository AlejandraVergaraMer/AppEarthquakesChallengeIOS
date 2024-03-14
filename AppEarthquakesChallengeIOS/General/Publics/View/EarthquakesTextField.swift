//
//  EarthquakesTextField.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI

struct EarthquakesTextField: View {
    var typeTextField: TypeTextField
    @Binding var text: String
    @Binding var showTextValidation: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(typeTextField.titleTextField)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            if typeTextField.isSecureCamp {
                SecureField(typeTextField.placeholderTextField, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                if showTextValidation {
                    Text(typeTextField.validationText)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                }
            } else {
                TextField(typeTextField.placeholderTextField, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                if showTextValidation {
                    Text(typeTextField.validationText)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                }
            }
            Spacer()
        }
        .frame(height: 100)
    }
}
