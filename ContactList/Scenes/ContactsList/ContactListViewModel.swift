//
//  ContactListViewModel.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
protocol ContactListViewModelType {
    var dataList: [Contact] { get }
    func loadContacts()
    var reloadData: Observable<Bool> { get }
    var error: Observable<String?> { get }
    var isLoading: Observable<Bool> { get }
}

final class ContactListViewModel: ContactListViewModelType {
    private(set) var dataList: [Contact] = []
    let apiClient: ApiClient
    let reloadData: Observable<Bool> = .init(false)
    let isLoading: Observable<Bool> = .init(false)
    let error: Observable<String?> = .init(nil)

    init(apiClient: ApiClient = HTTPClient()) {
        self.apiClient = apiClient
    }

    func loadContacts() {
        isLoading.next(false)
        apiClient.getData(of: ContactAPI.contactsList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                if let response: [Contact] = data.parse() {
                    self.dataList = response
                    self.reloadData.next(true)
                } else {
                    self.error.next(NetworkError.failedToParseData.localizedDescription)
                }
            case let .failure(error):
                self.error.next(error.localizedDescription)
            }
            self.isLoading.next(false)
        }
    }
}
