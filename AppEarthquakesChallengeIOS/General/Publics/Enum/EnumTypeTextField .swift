//
//  EnumTypeTextField.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation

enum TypeTextField {
    case email
    case password
    case loginPassword
    case repeatPassword
    case firtsName
    case lastName
    var titleTextField: String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Contraseña"
        case .loginPassword:
            return "Contraseña"
        case .repeatPassword:
            return "Repita su contraseña"
        case .firtsName:
            return "Nombre"
        case .lastName:
            return "Apellido"
        }
    }
    var placeholderTextField: String {
        switch self {
        case .email:
            return "Ingrese su email"
        case .password:
            return "Ingrese su contraseña"
        case .loginPassword:
            return "Ingrese su contraseña"
        case .repeatPassword:
            return "Ingrese su contraseña"
        case .firtsName:
            return "Ingrese su nombre"
        case .lastName:
            return "Ingrese su apellido"
        }
    }
    var validationText: String {
        switch self {
        case .email:
            return "Email inválido. Revise el formato de su email."
        case .password:
            return "La contraseña debe contener al menos 8 caracteres, una mayuscula, una minuscula y un numero."
        case .loginPassword:
            return "La contraseña es incorrecta."
        case .repeatPassword:
            return "La contraseña no coincide."
        case .firtsName, .lastName:
            return "Debes escribir al menos 3 caracteres"
        }
    }
    
    var isSecureCamp: Bool {
        switch self {
        case .email, .firtsName, .lastName:
            return false
        case .password, .loginPassword, .repeatPassword:
            return true
        }
    }
}
