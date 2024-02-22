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
                VStack(alignment: .leading) {
                    Text(viewModel.firtsNameType.titleTextField)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    TextField(viewModel.firtsNameType.placeholderTextField, text: $userFirtsName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userFirtsName) { newValue in
                            showFirtsNameValidation = !newValue.isEmpty
                            showFirtsNameValidation = viewModel.isValidTextField(newValue, type: viewModel.firtsNameType)
                            
                            isRegisterButtonEnable = !showFirtsNameValidation && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                        }
                    if showFirtsNameValidation {
                        Text(viewModel.firtsNameType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 10)
                VStack(alignment: .leading) {
                    Text(viewModel.lastNameType.titleTextField)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    TextField(viewModel.lastNameType.placeholderTextField, text: $userLastName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userLastName) { newValue in
                            showLastNameValidation = !newValue.isEmpty
                            showLastNameValidation = viewModel.isValidTextField(newValue, type: viewModel.lastNameType)
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !showLastNameValidation && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                        }
                    if showLastNameValidation {
                        Text(viewModel.lastNameType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 10)
                VStack(alignment: .leading) {
                    Text(viewModel.emailType.titleTextField)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    TextField(viewModel.emailType.placeholderTextField, text: $userEmail)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userEmail) { newValue in
                            showEmailValidation = !newValue.isEmpty
                            showEmailValidation = viewModel.isValidTextField(newValue, type: viewModel.emailType)
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !showEmailValidation && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                        }
                    if showEmailValidation {
                        Text(viewModel.emailType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 10)
                VStack(alignment: .leading) {
                    Text(viewModel.passwordType.titleTextField)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    SecureField(viewModel.passwordType.placeholderTextField, text: $userPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userPassword) { newValue in
                            showPasswordValidation = !newValue.isEmpty
                            showPasswordValidation = viewModel.isValidTextField(newValue, type: viewModel.passwordType)
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !showPasswordValidation && !userRepeatPassword.isEmpty
                        }
                    if showPasswordValidation {
                        Text(viewModel.passwordType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 10)
                VStack(alignment: .leading) {
                    Text(viewModel.repeatPassword.titleTextField)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    SecureField(viewModel.repeatPassword.placeholderTextField, text: $userRepeatPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userRepeatPassword) { newValue in
                            showRepeatPasswordValidation = !newValue.isEmpty
                            showRepeatPasswordValidation = userPassword != newValue
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !showRepeatPasswordValidation
                        }
                    if showRepeatPasswordValidation {
                        Text(viewModel.repeatPassword.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 20)
                
                Button("Registrarse") {
                    if !showFirtsNameValidation && !showLastNameValidation && !showEmailValidation && !showPasswordValidation && !showRepeatPasswordValidation {
                        debugPrint("\(!showFirtsNameValidation) && \(!showLastNameValidation) && \(!showEmailValidation) && \(!showPasswordValidation) && \(!showRepeatPasswordValidation)")
                        viewModel.saveUserData(firtsName: userFirtsName,lastName: userLastName,
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
/*EarthquakesTextField(typeTextField: .firtsName)
    .padding(.bottom, 10)

EarthquakesTextField(typeTextField: .lastName)
    .padding(.bottom, 10)

EarthquakesTextField(typeTextField: .email)
    .padding(.bottom, 10)

EarthquakesTextField(typeTextField: .password)
    .padding(.bottom, 10)

EarthquakesTextField(typeTextField: .repeatPassword)
    .padding(.bottom, 20)*/
/*Button("Volver") {
    
}
.font(.title3)
.fontWeight(.bold)
.foregroundColor(.secondary)
.padding(.vertical, 5)
.padding(.horizontal, 30)
.background(.white)
.border(Color.secondary, width:  2)
.cornerRadius(5)*/

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: .init(successAlert: {
            print("Succes alert")
        }, failureAlert: {
            print("Failure alert")
        }))
    }
}

