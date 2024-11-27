//
//  String+Extensions.swift
//  Utilities
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIKit

public extension String {
    var toURL: URL? {
        let stringUrl = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        if let stringUrl = stringUrl {
            return URL(string: stringUrl)
        } else {
            return nil
        }
    }

    var isValidURLString: Bool {
        guard let url = URL(string: self) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    func openURL() {
        guard let url = self.toURL, isValidURLString else { return }
        UIApplication.shared.open(url)
    }

    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var removeAllWhitespaces: String {
        String(self.filter { !" \n\t\r".contains($0) })
    }

    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var capitalized: String {
        guard self.contains(" ") else {
            let values = self.lowercased().split(separator: " ")
            let text = values.compactMap { $0.prefix(1).uppercased() + $0.dropFirst().lowercased() }
            return text.joined(separator: " ")
        }

        return self.prefix(1).uppercased() + self.dropFirst().lowercased()
    }

    func textSize(with font: UIFont) -> CGRect {
        let boundingSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return NSString(string: self).boundingRect(
            with: boundingSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
    }

    func toInt() -> Int? {
        Int(self)
    }
}

// MARK: - Subscripts
public extension String {
    subscript (index: Int) -> String {
        self[index ..< index + 1]
    }

    subscript (ranger: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, ranger.lowerBound)),
                                            upper: min(count, max(0, ranger.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        let rangeLast: Range<Index> = start..<end
        return String(self[rangeLast])
    }
}
