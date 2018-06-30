//
//  SearchDataTableCell.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

class SearchDataTableCell: UITableViewCell {

    func setup(with data: SearchData) {
        textLabel?.text = data.title
    }
}
