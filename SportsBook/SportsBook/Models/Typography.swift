//
//  Typography.swift
//  Sportsbook
//
//  Created by Kristina Simova on 13.03.24.
//

import UIKit

struct TypographyData {
    let letterSpacing: CGFloat
    let font: UIFont?
}

public enum Typography {
    case bigHeading
    case heading
    case mediumHeading
    case smallHeading

    var value: TypographyData {
        switch self {
        case .bigHeading:
            return TypographyData(letterSpacing: -0.3, font: PlayFont.play(.bold, size: 34))
        case .heading:
            return TypographyData(letterSpacing: -0.3, font: PlayFont.play(.bold, size: 20))
        case .mediumHeading:
            return TypographyData(letterSpacing: -0.3, font: InterFont.inter(.regular, size: 16))
        case .smallHeading:
            return TypographyData(letterSpacing: -0.3, font: InterFont.inter(.regular, size: 14))
        }
    }
}

enum PlayFont {
    case bold

    var value: String {
        switch self {
        case .bold:
            return "Bold"
        }
    }

    static func play(_ type: PlayFont, size: CGFloat) -> UIFont? {
        return UIFont(name: "Play-\(type.value)", size: size)
    }
}

enum InterFont {
    case regular

    var value: String {
        switch self {
        case .regular:
            return "Regular"
        }
    }

    static func inter(_ type: InterFont, size: CGFloat) -> UIFont? {
        return UIFont(name: "Inter-\(type.value)", size: size)
    }
}

