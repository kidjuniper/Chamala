//
//  CountCellWidthFromString.swift
//  Chamala
//
//  Created by Nikita Stepanov on 07.04.2024.
//

import Foundation

extension String {
    func generateWidthSmall() -> CGFloat {
        return CGFloat(max(10,
                           (self.count) * 6 + 6))
    }
}

extension String {
    func generateWidthMedium() -> CGFloat {
        return CGFloat(max(10,
                           (self.count) * 8 + 8))
    }
}
