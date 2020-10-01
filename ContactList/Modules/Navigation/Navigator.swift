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
    private static var homeNavigationController: UINavigationController!

    private init() {}

    func set(window: UIWindow) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let splitViewController = UISplitViewController()
            let contactsController = Destination.contactsList.controller
            let detailsController = Destination.contactDetails(of: nil).controller
            let masterNavigationController = UINavigationController(rootViewController: contactsController)
            let detailsNavigationController = UINavigationController(rootViewController: detailsController)
            splitViewController.viewControllers = [masterNavigationController, detailsNavigationController]
            splitViewController.delegate = self
            splitViewController.preferredDisplayMode = .primaryOverlay

            detailsController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
            detailsNavigationController.topViewController?.navigationItem.leftItemsSupplementBackButton = true
            AppNavigator.homeNavigationController = masterNavigationController
            window.rootViewController = splitViewController

        } else {
            AppNavigator.homeNavigationController = UINavigationController(rootViewController: Destination.contactsList.controller)
            window.rootViewController = AppNavigator.homeNavigationController
        }
        window.makeKeyAndVisible()
    }

    func push(_ dest: Destination) {
        AppNavigator.homeNavigationController.pushViewController(dest.controller, animated: true)
    }
}

extension AppNavigator: UISplitViewControllerDelegate {
    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? ContactDetailsController else { return false }
        if topAsDetailController.contact == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}
