//
//  Rx.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation
import RxSwift

/// Observable that can never complete
typealias PublishObservable = Observable

/// PublishObservable that return last emitted item on subscription
typealias BehaviourObservable = PublishObservable
