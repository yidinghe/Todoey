//
//  Category.swift
//  Todoey
//
//  Created by Yiding He on 7/22/19.
//  Copyright © 2019 Yiding He. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}

