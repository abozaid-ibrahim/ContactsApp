//
//  Destination.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import UIKit
enum Destination {
    case contactsList
    case contactDetails(of: Contact)
    var controller: UIViewController {
        switch self {
        case .contactsList:
            return ContactListController(with: ContactListViewModel())
        case let .contactDetails(contact):
            let contactVC = ContactDetailsController()
            contactVC.contact = contact
            return contactVC
        }
    }
}
