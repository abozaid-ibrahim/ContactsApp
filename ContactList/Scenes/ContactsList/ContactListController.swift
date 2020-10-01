//
//  ContactListController.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import UIKit

final class ContactListController: UITableViewController {
    private let viewModel: ContactListViewModelType
    private var contactsList: [Contact] { return viewModel.dataList }

    init(with viewModel: ContactListViewModelType) {
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
        tableView.tableFooterView = ActivityIndicatorFooterView()
        viewModel.loadContacts()
        bindToViewModel()
    }

    private var indicator: ActivityIndicatorFooterView? {
        return tableView.tableFooterView as? ActivityIndicatorFooterView
    }

    func bindToViewModel() {
        viewModel.reloadData.subscribe { [weak self] reload in
            DispatchQueue.main.async { if reload { self?.tableView.reloadData() } }
        }
        viewModel.isLoading.subscribe { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.sectionFooterHeight = isLoading ? 80 : 0
                self.indicator?.set(isLoading: isLoading)
            }
        }
        viewModel.error.subscribe { [weak self] error in
            guard let self = self, let msg = error else { return }
            DispatchQueue.main.async { self.show(error: msg) }
        }
    }
}

// MARK: - Table view data source

extension ContactListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableCell.identifier, for: indexPath) as! ContactTableCell
        cell.setData(for: contactsList[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppNavigator.shared.push(.contactDetails(of: contactsList[indexPath.row]))
    }
}
