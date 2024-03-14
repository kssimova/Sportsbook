//
//  UIColorExtension.swift
//  SportsBook
//
//  Created by Kristina Simova on 13.03.24.
//

import UIKit

/**
 *  Extension to provide convenience methods for UIColor.
 */
extension UIColor {
    // Convenience initializer to create UIColor from hex string
    // Parameters:
    // - hex: The hexadecimal color string (e.g., "#RRGGBB" or "RRGGBB")
    // - alpha: The alpha value (opacity) of the color (default is 1.0, fully opaque)
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        // Remove leading and trailing whitespaces and newlines from the hex string
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Remove the '#' character if present in the hex string
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        // Initialize an unsigned 64-bit integer to hold the RGB value
        var rgb: UInt64 = 0

        // Use Scanner to scan the hex string and convert it to an unsigned 64-bit integer
        guard Scanner(string: hexString).scanHexInt64(&rgb) else { return nil }

        // Extract the red, green, and blue components from the RGB value
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        // Initialize the UIColor with the extracted RGB components and alpha value
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

