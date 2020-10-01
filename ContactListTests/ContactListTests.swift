//
//  ContactListTests.swift
//  ContactListTests
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

@testable import ContactList
import XCTest

final class ContactListTests: XCTestCase {
    func testLoadContactsSuccessfullyFromAPI() throws {
        let viewModel = ContactListViewModel(apiClient: MockedAPIClient_Success())
        viewModel.loadContacts()
        let reloadExp = expectation(description: "WaitDataFetching")
        viewModel.reloadData.subscribe { _ in
            XCTAssertEqual(viewModel.dataList.count, 2)
            reloadExp.fulfill()
        }

        waitForExpectations(timeout: 0.01, handler: nil)
    }
}

final class MockedAPIClient_Success: ApiClient {
    func getData(of request: RequestBuilder, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let data = """
        [{
        "id": "1",
        "name": "Rylan Stroman",
        "email": "Georgianna.Bayer@yahoo.com",
        "phoneNumber": "1-035-227-1211 x5022"
        },
        {
        "id": "1",
        "name": "Rylan Stroman",
        "email": "Georgianna.Bayer@yahoo.com",
        "phoneNumber": "1-035-227-1211 x5022"
        }]
        """.data(using: .utf8)!
        completion(.success(data))
    }
}
