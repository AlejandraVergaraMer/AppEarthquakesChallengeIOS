//
//  RegisterViewModel.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation

class RegisterViewModel {
    var firtsNameType: TypeTextField = .firtsName
    var lastNameType: TypeTextField = .lastName
    var emailType: TypeTextField = .email
    var passwordType: TypeTextField = .password
    var repeatPassword: TypeTextField = .repeatPassword
    /*@Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }*/

    init() {
    }
    
    func saveUserData(firtsName: String, lastName: String, email: String, password: String) {
        UserDefaults.standard.set(firtsName, forKey: "firtsName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    func isValidTextField(_ value: String, type: TypeTextField) -> Bool {
        var regularExpression = ""
        switch type {
        case .email:
            regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        case .password:
            regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        case .firtsName, .lastName:
            regularExpression = ".{3,}"
        default:
            regularExpression = ""
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if predicate.evaluate(with: value) {
            return true
        } else {
            return false
        }
    }
    /*init() {
        //self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }*/
}
