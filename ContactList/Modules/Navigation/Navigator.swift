//
//  Navigator.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import UIKit

final class AppNavigator {
    static let shared = AppNavigator()
    private static var navigationController: UINavigationController!

    private init() {}

    func set(window: UIWindow) {
        AppNavigator.navigationController = UINavigationController(rootViewController: Destination.contactsList.controller)
        window.rootViewController = AppNavigator.navigationController
        window.makeKeyAndVisible()
    }

    func push(_ dest: Destination) {
        AppNavigator.navigationController.pushViewController(dest.controller, animated: true)
    }

    
}
