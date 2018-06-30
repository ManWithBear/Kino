//
//  UITableView.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

protocol NibLoadable { }
extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
extension UITableViewCell: NibLoadable { }

protocol Reusable { }
extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: Reusable { }

extension UITableView {
    func register<T: UITableViewCell>(_ : T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
