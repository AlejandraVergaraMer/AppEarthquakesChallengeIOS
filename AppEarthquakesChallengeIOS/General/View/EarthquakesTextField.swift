//
//  EarthquakesTextField.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI

struct EarthquakesTextField: View {
    var typeTextField: TypeTextField
    @State private var text = ""
    @State private var showTextValidation = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(typeTextField.titleTextField)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            TextField(typeTextField.placeholderTextField, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 5)
                .onChange(of: text) { newValue in
                    //showTextValidation = isValidTextField(newValue, type: typeTextField)//!newValue.isEmpty
                }
            if showTextValidation {
                Text(typeTextField.validationText)
                    .font(.system(size: 14))
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .frame(height: 100)
        //.background(Color.red)
    }
}

struct EarthquakesTextField_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakesTextField(typeTextField: .email)
    }
}
