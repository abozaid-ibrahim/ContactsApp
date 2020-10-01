//
//  ContactListViewModel.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
final class ContactListViewModel: ContactListViewModelType {
    var dataList: [Contact] = [(), (), ()]
    let apiClient: ApiClient

    init(apiClient: ApiClient = HTTPClient()) {
        self.apiClient = apiClient
    }

    func loadData(){
        apiClient.getData(of: ContactAPI.contactsList) { [weak self] result in
            
        }

    }
}
