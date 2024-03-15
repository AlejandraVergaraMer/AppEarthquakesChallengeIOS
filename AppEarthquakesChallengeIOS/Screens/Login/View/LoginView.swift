//
//  LoginView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI
import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapLogin()
    func didTapRegister()
}

extension LoginView {
    init(delegate: LoginViewDelegate) {
        self.delegate = delegate
    }
}

struct LoginView: View {
    var emailType: TypeTextField = .email
    var passwordType: TypeTextField = .loginPassword
    weak var delegate: LoginViewDelegate?
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var showEmailValidation = false
    @State private var showPasswordValidation = false
    @State private var isloginButtonDisable = true
    @State private var showFailureAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.5), .pink.opacity(0.3), .red.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    EarthquakesTextField(typeTextField: emailType, text: $userEmail, showTextValidation: $showEmailValidation)
                        .onChange(of: userEmail) { newValue in
                            let saveEmail = UserDefaults.standard.string(forKey: "email")
                            showEmailValidation = newValue != saveEmail//!newValue.isEmpty
                        }
                        .padding(.bottom, 30)
                    EarthquakesTextField(typeTextField: passwordType, text: $userPassword, showTextValidation: $showPasswordValidation)
                        .onChange(of: userPassword, perform: { newValue in
                            let savePassword = UserDefaults.standard.string(forKey: "password")
                            showPasswordValidation = newValue != savePassword
                        })
                        .padding(.bottom, 30)
                    Button("Iniciar sesión") {
                        if SessionManager.shared.isValidCredentials(email: userEmail, password: userPassword) {
                            SessionManager.shared.login()
                            delegate?.didTapLogin()
                        } else {
                            showFailureAlert = true
                        }
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 30)
                    .background(.white)
                    .border(Color.secondary, width:  2)
                    .cornerRadius(5)
                    Button("Registrate") {
                        delegate?.didTapRegister()
                    }
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .alert(isPresented: $showFailureAlert) {
                    Alert(title: Text("¡Ops! Hubo un problema"), message: Text("El email o la contraseña son incorrectos"), dismissButton: .default(Text("Cerrar")))
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
