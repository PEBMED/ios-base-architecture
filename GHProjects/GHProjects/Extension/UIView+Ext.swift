//
//  CodeView.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

// swiftlint:disable file_types_order
struct AnchoredPositionConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

struct AnchoredSizeConstraints {
    var width, height: NSLayoutConstraint?
}

struct AnchoredXYConstraints {
    var x: NSLayoutXAxisAnchor?
    var y: NSLayoutYAxisAnchor?
}

extension UIView {
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero) -> AnchoredPositionConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredPositionConstraints()

        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }

        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }

        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing].forEach { $0?.isActive = true }

        return anchoredConstraints
    }

    @discardableResult
    func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredPositionConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredPositionConstraints()

        if let top = superview?.topAnchor {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let leading = superview?.leadingAnchor {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }

        if let bottom = superview?.bottomAnchor {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if let trailing = superview?.trailingAnchor {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }

        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing].forEach { $0?.isActive = true }

        return anchoredConstraints
    }

    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }

        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }

    func centerX(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }

    func centerY(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @discardableResult
    func anchor(height: CGFloat? = nil, width: CGFloat? = nil) -> AnchoredSizeConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredSizeConstraints = AnchoredSizeConstraints()

        if let width = width {
            anchoredSizeConstraints.width = widthAnchor.constraint(equalToConstant: width)
        }

        if let height = height {
            anchoredSizeConstraints.height = heightAnchor.constraint(equalToConstant: height)
        }

        [anchoredSizeConstraints.width, anchoredSizeConstraints.height].forEach { $0?.isActive = true }

        return anchoredSizeConstraints
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
