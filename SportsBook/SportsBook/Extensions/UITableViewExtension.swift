//
//  UITableViewExtension.swift
//  SportsBook
//
//  Created by Kristina Simova on 11.03.24.
//

import UIKit

/**
 *  Extension to provide convenience methods for UITableView.
 */
extension UITableView {
    
    /**
     *  Registers a reusable cell class for use in creating new table cells.
     *
     *  - Parameter cellClass: The type of the cell class to register.
     */
    public func register<C: ReusableCell>(cellClass: C.Type) where C: NibLoadableView {
        register(C.nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    /**
     *  Dequeues a reusable cell for the specified reuse identifier and adds it to the table view.
     *
     *  - Parameter indexPath: The index path specifying the location of the cell.
     *  - Returns: A dequeued table view cell of the specified type.
     */
    public func dequeueReusableCell<T: UITableViewCell> (forIndexPath indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("The dequeued cell is not an instance of \(T.reuseIdentifier).")
        }
        return cell
    }
}
