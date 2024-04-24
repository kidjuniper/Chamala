//
//  ArrayContainsItemWithTag.swift
//  Chamala
//
//  Created by Nikita Stepanov on 06.04.2024.
//

import Foundation
import UIKit

extension [CellData] {
    func containsItemWithTag(tag: Int) -> Bool {
        for i in self {
            if i.tag == tag {
                return true
            }
        }
        return false
    }
}
