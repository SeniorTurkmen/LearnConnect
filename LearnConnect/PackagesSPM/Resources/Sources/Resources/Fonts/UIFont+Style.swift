//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

extension UIFont {
    public class func semiBold(_ size: CGFloat) -> UIFont {
        return font(size: size, weight: .semiBold)
    }
    
    public class func regular(_ size: CGFloat) -> UIFont {
        return font(size: size, weight: .regular)
    }
    
    public class func thin(_ size: CGFloat) -> UIFont {
        return font(size: size, weight: .thin)
    }
    
    public class func bold(_ size: CGFloat) -> UIFont {
        return font(size: size, weight: .bold)
    }
    
    public class func medium(_ size: CGFloat) -> UIFont {
        return font(size: size, weight: .medium)
    }
    
    public class func light(_ size: CGFloat) -> UIFont {
        return font(size: size, weight: .light)
    }
    
    public class func book(_ size: CGFloat) -> UIFont {
        return font(size: size, weight: .book)
    }
}
