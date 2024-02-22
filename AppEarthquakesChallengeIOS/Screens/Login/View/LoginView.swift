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
                    VStack(alignment: .leading) {
                        Text(emailType.titleTextField)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        TextField(emailType.placeholderTextField, text: $userEmail)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(radius: 5)
                            .onChange(of: userEmail) { newValue in
                                let saveEmail = UserDefaults.standard.string(forKey: "email")
                                showEmailValidation = newValue != saveEmail//!newValue.isEmpty
                            }
                        if showEmailValidation {
                            Text(emailType.validationText)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 30)
                    VStack(alignment: .leading) {
                        Text(passwordType.titleTextField)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        SecureField(passwordType.placeholderTextField, text: $userPassword)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(radius: 5)
                            .onChange(of: userPassword) { newValue in
                                let savePassword = UserDefaults.standard.string(forKey: "password")
                                showPasswordValidation = newValue != savePassword
                            }
                        if showPasswordValidation {
                            Text(passwordType.validationText)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 30)
                    Button("Iniciar sesión") {
                        let saveEmail = UserDefaults.standard.string(forKey: "email")
                        let savePassword = UserDefaults.standard.string(forKey: "password")
                        if userEmail == saveEmail && userPassword == savePassword {
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
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

/*EarthquakesTextField(typeTextField: .email)
    .padding(.bottom, 20)
EarthquakesTextField(typeTextField: .password)
    .padding(.bottom, 30)*/

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
