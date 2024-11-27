//
//  UIFont+Extensions.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

extension UIFont {
   // MARK: - Fonts
   enum FontWeight: String {
       case black = "Gotham-Black"
       case regular = "Gotham-Regular"
       case thin = "Gotham-Thin"
       case light = "Gotham-Light"
       // MARK: - w700
       case bold = "Gotham-Bold"
       // MARK: - w500
       case medium = "Gotham-Medium"
       // MARK: - 400
       case book = "Gotham-Book"
       // MARK: - 600
       case semiBold = "Gotham-SemiBold"
       
       var name: String {
           rawValue
       }
   }

   // MARK: - Privates
   class func font(size: CGFloat, weight: FontWeight) -> UIFont {
       guard let font = UIFont(name: weight.name, size: size) else {
           registerFont(name: weight.name)
           return UIFont(name: weight.name, size: size) ?? UIFont.systemFont(ofSize: size)
       }
       return font
   }

   static func registerFont(name: String) {
       guard let pathForResourceString = Bundle.module.path(forResource: name, ofType: "otf"),
             let fontData = NSData(contentsOfFile: pathForResourceString),
             let dataProvider = CGDataProvider(data: fontData),
             let fontRef = CGFont(dataProvider) else { return }
       var error: UnsafeMutablePointer<Unmanaged<CFError>?>?
       if CTFontManagerRegisterGraphicsFont(fontRef, error) == false {
           return
       }
       error = nil
   }
}
