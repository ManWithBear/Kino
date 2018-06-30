//
//  SearchTableManager.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

class SearchTableManager: NSObject {
    typealias OnSelectCallback = (SearchItem, Int) -> Void

    weak var table: UITableView? {
        didSet {
            table.map { self.setup(with: $0) }
        }
    }

    var items: [SearchItem] = [] {
        didSet {
            table?.reloadData()
        }
    }

    var onItemSelect: OnSelectCallback?
    var onLoadingAppearence: (() -> Void)?

    init(_ table: UITableView?) {
        self.table = table
        super.init()
        table.map { self.setup(with: $0) }
    }

    func setup(with table: UITableView) {
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = 44
        table.register(LoadingTableCell.self)
        table.register(ErrorTableCell.self)
        table.register(SearchDataTableCell.self)
    }
}

extension SearchTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .loading:
            return loadingCell(at: indexPath, from: tableView)
        case .error(msg: let msg):
            return errorCell(with: msg, at: indexPath, from: tableView)
        case .data(let data):
            return cell(for: data, at: indexPath, from: tableView)
        }
    }
}

extension SearchTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table?.deselectRow(at: indexPath, animated: true)
        onItemSelect?(items[indexPath.row], indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        guard case .loading = item else { return }
        onLoadingAppearence?()
    }
}

// MARK: - Cells
private extension SearchTableManager {
    func loadingCell(at index: IndexPath, from table: UITableView) -> LoadingTableCell {
        return table.dequeueReusableCell(for: index)
    }

    func errorCell(with msg: String, at index: IndexPath, from table: UITableView) -> ErrorTableCell {
        let cell: ErrorTableCell = table.dequeueReusableCell(for: index)
        cell.setup(with: msg)
        return cell
    }

    func cell(for data: SearchData, at index: IndexPath, from table: UITableView) -> SearchDataTableCell {
        let cell: SearchDataTableCell = table.dequeueReusableCell(for: index)
        cell.setup(with: data)
        return cell
    }
}
