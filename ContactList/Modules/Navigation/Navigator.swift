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
    private init() {}
    func set(window: UIWindow) {
        let navigationController = UINavigationController(rootViewController: Destination.contactsList.controller)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
