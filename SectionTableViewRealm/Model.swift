//
//  Model.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/13/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import Foundation
import RealmSwift

class Transaction: Object {
    @objc dynamic var payee: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var date = Date()
}
