//
//  ToDoTableViewCell.swift
//  SecondProject
//
//  Created by JEON JUNHA on 2021/03/15.
//

import UIKit
class ToDoTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI() {
        [titleLabel, timeLabel].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 140),
            
        ])
    }
}
