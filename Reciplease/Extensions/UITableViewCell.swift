//
//  UITableViewCell.swift
//  Reciplease
//
//  Created by Perveaux Nicolas on 01/03/2024.
//

import UIKit

// MARK: - Extension to custom views of TableViewCell
extension UITableViewCell {
    // custom views
    func customViewCell(view: UIImageView) {
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
    }
}
