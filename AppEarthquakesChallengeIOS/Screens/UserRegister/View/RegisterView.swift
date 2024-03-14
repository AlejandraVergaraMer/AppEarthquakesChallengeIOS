//
//  RegisterView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI


struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @State private var userFirtsName = ""
    @State private var userLastName = ""
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var userRepeatPassword = ""
    @State private var showFirtsNameValidation = false
    @State private var showLastNameValidation = false
    @State private var showEmailValidation = false
    @State private var showPasswordValidation = false
    @State private var showRepeatPasswordValidation = false
    @State private var isRegisterButtonEnable = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.5), .pink.opacity(0.3), .red.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                EarthquakesTextField(typeTextField: viewModel.firtsNameType, text: $userFirtsName, showTextValidation: $showFirtsNameValidation)
                    .onChange(of: userFirtsName, perform: { newValue in
                        showFirtsNameValidation = !newValue.isEmpty
                        showFirtsNameValidation = viewModel.isValidTextField(newValue, type: viewModel.firtsNameType)
                        
                        isRegisterButtonEnable = !showFirtsNameValidation && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                    })
                    .padding(.bottom, 10)
                EarthquakesTextField(typeTextField: viewModel.lastNameType, text: $userLastName, showTextValidation: $showLastNameValidation)
                    .onChange(of: userLastName, perform: { newValue in
                        showLastNameValidation = !newValue.isEmpty
                        showLastNameValidation = viewModel.isValidTextField(newValue, type: viewModel.lastNameType)
                        isRegisterButtonEnable = !userFirtsName.isEmpty && !showLastNameValidation && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                    })
                    .padding(.bottom, 10)
                EarthquakesTextField(typeTextField: viewModel.emailType, text: $userEmail, showTextValidation: $showEmailValidation)
                    .onChange(of: userEmail, perform: { newValue in
                        showEmailValidation = !newValue.isEmpty
                        showEmailValidation = viewModel.isValidTextField(newValue, type: viewModel.emailType)
                        isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !showEmailValidation && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                    })
                    .padding(.bottom, 10)
                EarthquakesTextField(typeTextField: viewModel.passwordType, text: $userPassword, showTextValidation: $showPasswordValidation)
                    .onChange(of: userPassword, perform: { newValue in
                        showPasswordValidation = !newValue.isEmpty
                        showPasswordValidation = viewModel.isValidTextField(newValue, type: viewModel.passwordType)
                        isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !showPasswordValidation && !userRepeatPassword.isEmpty
                    })
                    .padding(.bottom, 10)
                EarthquakesTextField(typeTextField: viewModel.repeatPassword, text: $userRepeatPassword, showTextValidation: $showRepeatPasswordValidation)
                    .onChange(of: userRepeatPassword, perform: { newValue in
                        showRepeatPasswordValidation = !newValue.isEmpty
                        showRepeatPasswordValidation = userPassword != newValue
                        isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !showRepeatPasswordValidation
                    })
                    .padding(.bottom, 20)
                Button("Registrarse") {
                    if !showFirtsNameValidation && !showLastNameValidation && !showEmailValidation && !showPasswordValidation && !showRepeatPasswordValidation {
                        debugPrint("\(!showFirtsNameValidation) && \(!showLastNameValidation) && \(!showEmailValidation) && \(!showPasswordValidation) && \(!showRepeatPasswordValidation)")
                        SessionManager.shared.saveUserData(firtsName: userFirtsName,lastName: userLastName,
                                               email: userEmail, password: userPassword)
                        viewModel.successAlert()
                    } else {
                        viewModel.failureAlert()
                    }
                }
                    .disabled(!isRegisterButtonEnable)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(isRegisterButtonEnable ? .secondary : .secondary.opacity(0.5))
                    .padding(.vertical, 5)
                    .padding(.horizontal, 30)
                    .background(.white)
                    .border(isRegisterButtonEnable ? Color.secondary : Color.white, width:  2)
                    .cornerRadius(5)
                Spacer()
            }
            .padding()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: .init(successAlert: {
            print("Succes alert")
        }, failureAlert: {
            print("Failure alert")
        }))
    }
}

