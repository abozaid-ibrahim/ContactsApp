//
//  ContactListController.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import UIKit
protocol ContactListViewModelType {
    var dataList: [Contact] { get }
}

typealias ViewModel = String
typealias Contact = Void
final class ContactListController: UITableViewController {
    private let viewModel: ContactListViewModelType
    private var contactsList: [Contact] { return viewModel.dataList }

    init(viewModel: ContactListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        tableView.register(ContactTableCell.self)
        tableView.rowHeight = 90
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableCell.identifier, for: indexPath) as! ContactTableCell

        return cell
    }
}
