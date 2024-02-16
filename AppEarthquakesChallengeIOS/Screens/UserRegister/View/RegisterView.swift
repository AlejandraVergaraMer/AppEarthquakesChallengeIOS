//
//  RegisterView.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import SwiftUI

struct RegisterView: View {
    var viewModel = RegisterViewModel()
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
    @State private var showSuccesAlert = false
    @State private var showFailureAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.5), .pink.opacity(0.3), .red.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading) {
                    Text(viewModel.firtsNameType.titleTextField)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    TextField(viewModel.firtsNameType.placeholderTextField, text: $userFirtsName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userFirtsName) { newValue in
                            showFirtsNameValidation = viewModel.isValidTextField(newValue, type: viewModel.firtsNameType)//!newValue.isEmpty
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                        }
                    if showFirtsNameValidation {
                        Text(viewModel.firtsNameType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading) {
                    Text(viewModel.lastNameType.titleTextField)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    TextField(viewModel.lastNameType.placeholderTextField, text: $userLastName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userLastName) { newValue in
                            showLastNameValidation = viewModel.isValidTextField(newValue, type: viewModel.lastNameType)//!newValue.isEmpty
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                        }
                    if showLastNameValidation {
                        Text(viewModel.lastNameType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading) {
                    Text(viewModel.emailType.titleTextField)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    TextField(viewModel.emailType.placeholderTextField, text: $userEmail)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userEmail) { newValue in
                            showEmailValidation = viewModel.isValidTextField(newValue, type: viewModel.emailType)//!newValue.isEmpty
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                        }
                    if showEmailValidation {
                        Text(viewModel.emailType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading) {
                    Text(viewModel.passwordType.titleTextField)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    SecureField(viewModel.passwordType.placeholderTextField, text: $userPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userPassword) { newValue in
                            showPasswordValidation = viewModel.isValidTextField(newValue, type: viewModel.passwordType)//!newValue.isEmpty
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
                        }
                    if showPasswordValidation {
                        Text(viewModel.passwordType.validationText)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 20)
                VStack(alignment: .leading) {
                    Text(viewModel.repeatPassword.titleTextField)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    SecureField(viewModel.repeatPassword.placeholderTextField, text: $userRepeatPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .onChange(of: userRepeatPassword) { newValue in
                            showRepeatPasswordValidation = userPassword == userRepeatPassword//!newValue.isEmpty
                            isRegisterButtonEnable = !userFirtsName.isEmpty && !userLastName.isEmpty && !userEmail.isEmpty && !userPassword.isEmpty && !userRepeatPassword.isEmpty
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
                        viewModel.saveUserData(firtsName: userFirtsName,lastName: userLastName,
                                               email: userEmail, password: userPassword)
                        showSuccesAlert = true
                    } else {
                        showFailureAlert = true
                    }
                }
                    .disabled(isRegisterButtonEnable)
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
            .alert(isPresented: $showSuccesAlert) {
                Alert(title: Text("Tu registro fue exitoso"), message: Text("Puedes volver a la pantalla anterior para iniciar sesión"), dismissButton: .default(Text("Cerrar")))
            }
            .alert(isPresented: $showFailureAlert) {
                Alert(title: Text("¡Ops! No pudimos registrarte"), message: Text("Revisa que todos los campos esten completados con la información correcta"), dismissButton: .default(Text("Cerrar")))
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
        RegisterView()
    }
}

