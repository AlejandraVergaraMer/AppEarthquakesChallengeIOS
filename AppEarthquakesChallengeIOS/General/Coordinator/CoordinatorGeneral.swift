//
//  CoordinatorGeneral.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator {
    var viewController: UIViewController? { get }
    var navigationController: UINavigationController? { get }
    
    func start()
}
extension Coordinator {
    var viewController: UIViewController? { nil }
    var navigationController: UINavigationController? { nil }
}

class CoordinatorGeneral: Coordinator {
    
    var navigationController: UINavigationController?
    var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //UserDefaults.standard.set(false, forKey: "isLoggedIn")
        if !isLoggedIn {
            let loginView = LoginView(delegate: self)
            let controller = UIHostingController(rootView: loginView)
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let serviceHome = EarthquakeListService(startTime: "2020-01-01", endTime: "2020-01-02")
            let providerHome = EarthquakeListProvider(serviceApi: serviceHome)
            let controller = EarthquakeListViewController(provider: providerHome, delegate: self)
            navigationController?.isNavigationBarHidden = false
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension CoordinatorGeneral: LoginViewDelegate {
    func didTapLogin() {
        debugPrint("Fue a pantalla Home")
        let serviceHome = EarthquakeListService(startTime: "2020-01-01", endTime: "2020-01-02")
        let providerHome = EarthquakeListProvider(serviceApi: serviceHome)
        let controller = EarthquakeListViewController(provider: providerHome, delegate: self)
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapRegister() {
        let viewModel = RegisterViewModel(successAlert: {
            let showSuccesAlert = UIAlertController(
                title: "Tu registro fue exitoso",
                message: "Puedes volver a la pantalla anterior para iniciar sesión",
                preferredStyle: .alert
            )
            showSuccesAlert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
            self.navigationController?.present(showSuccesAlert, animated: true)
        }, failureAlert: {
            let showFailureAlert = UIAlertController(
                title: "¡Ops! No pudimos registrarte",
                message: "Revisa que todos los campos esten completados con la información correcta",
                preferredStyle: .alert
            )
            showFailureAlert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
            self.viewController?.present(showFailureAlert, animated: true)
        })
        let controller = UIHostingController(rootView: RegisterView(viewModel: viewModel))
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CoordinatorGeneral: EarthquakeViewControllerDelegate {
    func closeSession() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        navigationController?.popViewController(animated: true)
        /*if isLoggedIn ?? nil {
            let loginView = LoginView(delegate: self)
            let loginController = UIHostingController(rootView: loginView)
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.pushViewController(loginController, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.popViewController(animated: true)
        }*/
    }
    
    func didTapDetails(idCell: String) {
        let service = DetailEarthquakeService(idEarthquake: idCell)
        let provider = DetailEarthquakeProvider(serviceApi: service)
        let viewModel = EarthquakeDetailViewModel(provider: provider)
        let controller = UIHostingController(rootView: DetailEarthquakeView(viewModel: viewModel))
        controller.navigationItem.backButtonDisplayMode = .minimal
        controller.navigationItem.leftItemsSupplementBackButton = true
        navigationController?.pushViewController(controller, animated: true)
    }
}
