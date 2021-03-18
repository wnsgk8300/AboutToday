//
//  CustomNewsCell.swift
//  Weather
//
//  Created by 신민희 on 2021/03/16.
//

import UIKit

class CustomNewsCell: UITableViewCell {
    // MARK: - Properties
    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    func setUI() {
        [mainImageView, titleLabel].forEach{
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2.0),
            mainImageView.widthAnchor.constraint(equalToConstant: 120),
//            mainImageView.heightAnchor.constraint(equalToConstant: 90),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -3),
            titleLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        titleLabel.numberOfLines = 0
        mainImageView.contentMode = .scaleAspectFit
    }
}
