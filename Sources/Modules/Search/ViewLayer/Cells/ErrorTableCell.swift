//
//  ErrorTableCell.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

class ErrorTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = .red
    }

    func setup(with msg: String) {
        textLabel?.text = msg
    }
}
