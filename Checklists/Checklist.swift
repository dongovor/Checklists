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

    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [Checklistitem]
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
    }

    init(name: String) {
        self.name = name
        super.init()
    }
}
