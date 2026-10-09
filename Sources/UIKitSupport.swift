// Copyright 2016 LinkedIn Corp.
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import UIKit

public typealias View = UIView

public typealias EdgeInsets = UIEdgeInsets

public typealias UserInterfaceLayoutDirection = UIUserInterfaceLayoutDirection

extension UIView {

    /// Converts `rect` from this view's coordinate space to its window's coordinate space.
    ///
    /// The conversion stops at the window (`to: nil`) on purpose. It used to go through
    /// `UIScreen.main.fixedCoordinateSpace`, which breaks on iPadOS 27: a window that is not
    /// full screen (resized at runtime, or launched inside a Stage Manager window) gets a window
    /// scene whose `screen` is not `UIScreen.main`, and converting between the two unrelated
    /// screens returns an infinite rect (`(inf, inf, 0, 0)`).
    /// Assigning that as a frame throws `CALayerInvalidGeometry`
    /// (see `LayoutArrangement.addSubview(_:maintainCoordinates:)`). `UIScreen.main` has also
    /// been deprecated since iOS 16. Views reparented by a `LayoutArrangement` always share a
    /// window, so the window is a sufficient common ancestor.
    func convertToAbsoluteCoordinates(_ rect: CGRect) -> CGRect {
        return convert(rect, to: nil)
    }

    /// Inverse of `convertToAbsoluteCoordinates(_:)`.
    func convertFromAbsoluteCoordinates(_ rect: CGRect) -> CGRect {
        return convert(rect, from: nil)
    }

    /// Expose API that is identical to NSView.
    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        if #available(iOS 9.0, *) {
            return UIView.userInterfaceLayoutDirection(for: semanticContentAttribute)
        } else {
            // Before iOS 9, there wasn't good support for RTL interfaces
            // (even the OS itself didn't swap interfaces right to left).
            // The best we can do is check the language direction of the preferred localization
            // and use that.
            if let isoLangCode = Bundle.main.preferredLocalizations.first {
                switch NSLocale.characterDirection(forLanguage: isoLangCode) {
                case .unknown, .leftToRight, .topToBottom, .bottomToTop:
                    return .leftToRight
                case .rightToLeft:
                    return .rightToLeft
                @unknown default:
                    return .leftToRight
                }
            } else {
                #if LAYOUTKIT_EXTENSION_DEFAULT_RIGHT_TO_LEFT
                    return .rightToLeft
                #else
                    return .leftToRight
                #endif
            }
        }
    }
}
