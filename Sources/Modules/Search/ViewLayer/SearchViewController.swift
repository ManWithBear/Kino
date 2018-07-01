//
//  SearchViewController.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet weak var errorView: UIView?
    @IBOutlet weak var errorLabel: UILabel?
    @IBOutlet weak var table: UITableView? {
        didSet {
            tableManager.table = table
        }
    }

    lazy var tableManager: SearchTableManager = {
        let manager = SearchTableManager(self.table)
        manager.onItemSelect = { [weak self] item, index in
            switch item {
            case .error: self?.viewModel.retryLoading()
            case .data: self?.viewModel.didSelectItem(at: index)
            case .loading: break
            }
        }
        manager.onLoadingAppearence = { [weak self] in self?.viewModel.loadData() }
        return manager
    }()

    let viewModel: SearchViewModel
    var bag = DisposeBag()
    var state: SearchState = .idle {
        didSet {
            move(to: state)
        }
    }

    // MARK: - Inits
    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "This controller not supported in storyboards")
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        move(to: state)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToState()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        bag = DisposeBag()
    }

    // MARK: - Actions
    @IBAction func didTapOnRetry() {
        viewModel.retryLoading()
    }

    func subscribeToState() {
        viewModel.searchStateStream
            .subscribe(
                onNext: { [weak self] in self?.state = $0 }
            )
            .disposed(by: bag)
    }

    func move(to state: SearchState) {
        switch state {
        case .idle:
            table?.isHidden = true
            loadingIndicator?.stopAnimating()
            errorView?.isHidden = true

        case .loading:
            table?.isHidden = true
            loadingIndicator?.startAnimating()
            errorView?.isHidden = true

        case .data(items: let items):
            table?.isHidden = false
            tableManager.items = items
            loadingIndicator?.stopAnimating()
            errorView?.isHidden = true

        case .error(msg: let error):
            print("Error: \(error)")
            table?.isHidden = true
            loadingIndicator?.stopAnimating()
            errorView?.isHidden = false
            errorLabel?.text = error
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        viewModel.didCancel()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didChangeSearch(searchText)
    }
}
