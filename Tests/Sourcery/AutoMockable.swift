//
//  AutoMockable.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino

// sourcery:begin: AutoMockable

// MARK: - Search module
extension SearchFactory { }
extension SearchFlow { }
extension SearchViewModel { }

// MARK: - Services
extension MovieSearchProvider { }

// sourcery:end: AutoMockable
