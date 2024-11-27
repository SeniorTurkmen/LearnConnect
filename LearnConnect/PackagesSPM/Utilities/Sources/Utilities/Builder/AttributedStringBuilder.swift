//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIKit

// swiftlint:disable all
public final class AttributedStringBuilder {
    private var baseAttributedString = NSMutableAttributedString()

    public var attributedString: NSAttributedString {
        return baseAttributedString
    }
    public var defaultAttributes: [Attribute] = []
    public init() {}

    public enum Attribute {
        case font(UIFont)
        case textColor(UIColor)
        case paragraphStyle(NSParagraphStyle)
        case alignment(NSTextAlignment)
        case lineSpacing(CGFloat)
        case multiLineHeight(CGFloat)
        case lineHeightMultiple(CGFloat)
        case underline(Bool)
        case strikethrough(Bool)
        case link(URL)
        case underlineColor(UIColor?)
        case strokeColor(UIColor?)


        var key: NSAttributedString.Key {
            return keyAndValue(for: self).0
        }

        var value: Any? {
            return keyAndValue(for: self).1
        }

        private func keyAndValue(
            for attribute: Attribute
        ) -> (NSAttributedString.Key, Any?) {
            switch attribute {
            case .font(let value):
                return (.font, value)
            case .paragraphStyle(let value):
                return (.paragraphStyle, value)
            case .alignment:
                return (.paragraphStyle, nil)
            case .lineSpacing:
                return (.paragraphStyle, nil)
            case .textColor(let value):
                return (.foregroundColor, value)
            case .multiLineHeight:
                return (.paragraphStyle, nil)
            case .lineHeightMultiple:
                return (.paragraphStyle, nil)
            case .underline(let value):
                return (.underlineStyle, value)
            case .strikethrough(let value):
                return (.strikethroughStyle, value)
            case .link(let value):
                return (.link, value)
            case .underlineColor(let value):
                return (.underlineColor, value)
            case .strokeColor(let value):
                return (.strokeColor, value)
            }
        }

        func configureParagraphStyle(
            _ paragraph: NSMutableParagraphStyle
        ) {
            switch self {
            case .paragraphStyle(let value):
                paragraph.setParagraphStyle(value)
            case .alignment(let value):
                paragraph.alignment = value
            case .lineSpacing(let value):
                paragraph.lineSpacing = value
            case .multiLineHeight(let value):
                paragraph.minimumLineHeight = value
            case .lineHeightMultiple(let value):
                paragraph.lineHeightMultiple = value
            default:
                fatalError("Not a paragraph style attribute")
            }
        }
    }

    @discardableResult
    public func text(
        _ string: String,
        attributes: [Attribute] = []
    ) -> AttributedStringBuilder {
        let attributes = attributesDictionary(withOverrides: attributes)
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        baseAttributedString.append(attributedString)
        return self
    }

    @discardableResult
    public func updateAttributed(
        _ string: String,
        attributes: [Attribute] = []
    ) -> AttributedStringBuilder {
        let mutableAttributedString = baseAttributedString.mutableString
        let range = mutableAttributedString.range(of: string)
        let updatedAttributes = attributesDictionary(withOverrides: attributes)
        let updatedAttributedString = NSAttributedString(string: string, attributes: updatedAttributes)
        baseAttributedString.replaceCharacters(in: range, with: updatedAttributedString)
        return self
    }

    @discardableResult
    public func attributedText(_ attributedString: NSAttributedString) -> AttributedStringBuilder {
        baseAttributedString.append(attributedString)
        return self
    }
    
    @discardableResult 
    public func image(_ anImage: UIImage, size: CGSize) -> AttributedStringBuilder {
        let attachment = NSTextAttachment()
        attachment.image = anImage
        attachment.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        baseAttributedString.append(attachmentString)
        return self
    }
    
    @discardableResult
    public func html(
        _ htmlString: String,
        attributes: [Attribute] = []
    ) -> AttributedStringBuilder {
        guard let data = htmlString.data(using: .utf8) else { return self }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        guard let attributedString else { return self }
        let attributes = attributesDictionary(withOverrides: attributes)
        let mutableAttributedString = NSAttributedString(
            string: attributedString.string,
            attributes: attributes
        )
        baseAttributedString.append(mutableAttributedString)
        return self
    }

    private func attributesDictionary(
        withOverrides overrides: [Attribute]
    ) -> [NSAttributedString.Key: Any] {
        var attributesDict: [NSAttributedString.Key: Any] = [:]
        let paragraphStyle = NSMutableParagraphStyle()

        (defaultAttributes + overrides).forEach {
            let key = $0.key
            let value = $0.value

            if key == .paragraphStyle {
                $0.configureParagraphStyle(paragraphStyle)
            } else {
                attributesDict[key] = value
            }
        }
        attributesDict[.paragraphStyle] = paragraphStyle
        return attributesDict
    }

    public func clearDefaultAttributes() {
        defaultAttributes.removeAll()
    }

    public func clean() {
        baseAttributedString.deleteCharacters(
            in: NSRange(location: 0, length: baseAttributedString.length)
        )
    }
}
//swiftlint:enable all
