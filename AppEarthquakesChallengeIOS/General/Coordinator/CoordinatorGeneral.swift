//
//  CoordinatorGeneral.swift
//  ChallengeEarthquakeIOS
//
//  Created by Alejandra Vergara Meriño on 18-01-24.
//

import Foundation
import UIKit
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate {
    var didFinish: ((Coordinator) -> Void)?
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        navigationController
    }
    public var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) { }
    
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool) { }

    func pushCoordinator(_ coordinator: Coordinator) {
        coordinator.didFinish = { [weak self ] coordinator in
            self?.popCoordinator(coordinator)
        }
        
        coordinator.start()
        
        childCoordinators.append(coordinator)
    }
    
    func popCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 == coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

class CoordinatorGeneral: Coordinator {
    var loginView: LoginView?
    
    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
        
    }
    
    override func start() {
        loginView = LoginView(delegate: self)
        let registerView = RegisterView()
        //let detailView = DetailEarthquakeView(viewModel: <#EarthquakeModelForDetail#>)
        //let tableController = EarthquakeListViewController(provider: )
        let controller = UIHostingController(rootView: loginView)
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(controller, animated: true)
    }
}

extension CoordinatorGeneral: LoginViewDelegate {
    func didTapLogin() {
        debugPrint("Fue a pantalla Home")
    }
    
    func didTapRegister() {
        let controller = UIHostingController(rootView: RegisterView())
        controller.navigationItem.backButtonDisplayMode = .minimal
        controller.navigationItem.leftItemsSupplementBackButton = true
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
