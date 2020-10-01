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
    var controller: UIViewController {
        return ContactListController(with: ContactListViewModel())
    }
}

