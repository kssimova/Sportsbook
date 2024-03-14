//
//  ReusableCell.swift
//  Sportsbook
//
//  Created by Kristina Simova on 11.03.24.
//

import UIKit

/**
 *  Represents a protocol for reusable table view cells.
 */
public protocol ReusableCell {
    /// The reuse identifier for the cell.
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    /// The default implementation of reuseIdentifier, which returns the name of the class.
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
