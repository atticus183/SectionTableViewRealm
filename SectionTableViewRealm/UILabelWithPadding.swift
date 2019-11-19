//
//  UILabelWithPadding.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/17/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit

class UILabelWithPadding: UILabel {

    var widthPadding: CGFloat = 0.0
    var heighPadding: CGFloat = 0.0
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + heighPadding
        let width = originalContentSize.width + widthPadding
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: width, height: height)
    }
}
