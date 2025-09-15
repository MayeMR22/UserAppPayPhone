//
//  BaseCoordinator.swift
//  UserAppPay
//
//  Created by Maye Rios on 15/09/25.
//

import UIKit

protocol CoordinatorType: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class BaseCoordinator: CoordinatorType {
    var childCoordinators: [CoordinatorType] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        fatalError("start() must be overridden")
    }

    func add(_ coordinator: CoordinatorType) {
        childCoordinators.append(coordinator)
    }

    func remove(_ coordinator: CoordinatorType) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
