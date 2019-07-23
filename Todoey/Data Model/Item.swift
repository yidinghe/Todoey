//
//  Item.swift
//  Todoey
//
//  Created by Yiding He on 7/22/19.
//  Copyright © 2019 Yiding He. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done:Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
