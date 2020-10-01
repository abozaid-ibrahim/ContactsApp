//
//  ContactResponse.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

struct Contact: Codable {
    let id: String
    let name: String
    let phoneNumber: String
    let email: String?
    let dateAdded: String?
    let jobTitle: String?
    let age: Int?
    let avatar: String?
}

