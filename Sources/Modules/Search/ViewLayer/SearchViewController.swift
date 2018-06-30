//
//  SearchViewController.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let viewModel: SearchViewModel

    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "This controller not supported in storyboards")
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
