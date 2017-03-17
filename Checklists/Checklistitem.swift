//
//  Checklistitem.swift
//  Checklists
//
//  Created by Dmitry Cherkasov on 3/14/17.
//  Copyright © 2017 Dmitry Cherkasov. All rights reserved.
//

import Foundation

class Checklistitem {
    var text = " "
    var checked = false

    func toggleChecked() {
        checked = !checked
    }
}
