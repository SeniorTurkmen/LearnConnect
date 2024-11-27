//
//  UIImageView+Extensions.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import SDWebImage
import UIKit

public extension UIImageView {
    func setImage(_ urlString: String?) {
        guard let urlString,
              let url = urlString.toURL else { return }
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(
            with: url,
            placeholderImage: nil,
            options: [.scaleDownLargeImages, .retryFailed]
        )
    }
}
