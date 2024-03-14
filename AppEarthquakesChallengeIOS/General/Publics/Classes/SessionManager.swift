//
//  SessionManager.swift
//  AppEarthquakesChallengeIOS
//
//  Created by Alejandra Vergara Meriño on 14-03-24.
//

import Foundation

class SessionManager {

    static let shared = SessionManager()

    private let userDefaults = UserDefaults.standard
    private let userLoggedInKey = "isLoggedIn"
    private let userIsFirstLogin = "isFistLogin"

    var isLoggedIn: Bool {
        return userDefaults.bool(forKey: userLoggedInKey)
    }
    
    var isFistLogin: Bool {
        return userDefaults.bool(forKey: userIsFirstLogin)
    }

    func login() {
        userDefaults.set(true, forKey: userLoggedInKey)
    }

    func logout() {
        userDefaults.set(false, forKey: userLoggedInKey)
    }

    func saveUserData(firtsName: String, lastName: String, email: String, password: String) {
        UserDefaults.standard.set(firtsName, forKey: "firtsName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    func isValidCredentials(email: String, password: String) -> Bool {
        let storedEmail = UserDefaults.standard.string(forKey: "email")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
        return email == storedEmail && password == storedPassword
        
    }
}
