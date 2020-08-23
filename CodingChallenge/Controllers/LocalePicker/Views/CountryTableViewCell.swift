//
//  CountryTableViewCell.swift
//  CodingChallenge
//
//  Created by Aung Ko Min on 23/8/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//
import UIKit

final class CountryTableViewCell: UITableViewCell {

    static let identifier = String(describing: CountryTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = nil
        contentView.backgroundColor = nil
        tintColor = UIColor.systemOrange
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        detailTextLabel?.textColor = .tertiaryLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure Selection
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryView = selected ? UIImageView(image: UIImage(systemName: "checkmark.circle.fill")) : nil
    }
    
    func configure(_ info: LocaleInfo) {
        textLabel?.text = info.country
        detailTextLabel?.text = info.code
        DispatchQueue.main.async {
            let size: CGSize = CGSize(width: 32, height: 32)
            let flag = info.flag?.imageWithSize(size: size, roundedRadius: 16)
            self.imageView?.image = flag
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
}
