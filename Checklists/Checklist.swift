//
//  Checklist.swift
//  Checklists
//
//  Created by Dmitry Cherkasov on 3/20/17.
//  Copyright © 2017 Dmitry Cherkasov. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

class Checklist: NSObject, NSCoding {
    var name = " "
    var items = [Checklistitem]()
    var iconName: String

    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [Checklistitem]
        iconName = aDecoder.decodeObject(forKey: "IconName") as! String
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "IconName")
    }

    init(name: String) {
        self.name = name
        iconName = "Appointments"
        super.init()
    }

    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
