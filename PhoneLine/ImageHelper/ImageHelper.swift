//
//  ImageHelper.swift
//  PhoneLine
//
//  Created by Mini-M14Marshaii on 2021/11/25.
//

import Foundation

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    UIGraphicsBeginImageContext(targetSize)
    let areaSize = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
    image.draw(in: areaSize)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
}

extension UIImage {
  func mergeWith(topImage: UIImage) -> UIImage {
    let bottomImage = self

    UIGraphicsBeginImageContext(size)
    let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
    bottomImage.draw(in: areaSize)

    topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)

    let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return mergedImage
  }
}
