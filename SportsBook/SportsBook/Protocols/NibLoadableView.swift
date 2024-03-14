//
//  NibLoadableView.swift
//  Sportsbook
//
//  Created by Kristina Simova on 11.03.24.
//

import UIKit

/**
 *  Represents a protocol for views that are loaded from nib files.
 */
public protocol NibLoadableView {
    /// The name of the nib file.
    static var nibName: String { get }
    /// The UINib object initialized with the nib file.
    static var nib: UINib { get }
}

extension NibLoadableView {
    /// The default implementation of nibName, which returns the name of the class.
    public static var nibName: String {
        return String(describing: self)
    }
    
    /// The default implementation of nib, which initializes a UINib object with the nib file.
    public static var nib: UINib {
        return UINib(nibName: Self.nibName, bundle: nil)
    }
}
