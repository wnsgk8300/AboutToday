//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by 신민희 on 2021/03/15.
//


import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    let temperatureLabel = UILabel()
    let cityLabel = UILabel()
    let weatherLabel = UILabel()
    let weatherImage = UIImageView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCell()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        [weatherImage, cityLabel, temperatureLabel, weatherLabel].forEach { (view) in
            self.contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            weatherImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 130),
            
            cityLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 10),
            cityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            cityLabel.heightAnchor.constraint(equalToConstant: 50),
            
            weatherLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 10),
            weatherLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            weatherLabel.heightAnchor.constraint(equalToConstant: 50),
            weatherLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            
            temperatureLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 20),
            temperatureLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            
        ])
        
    }
    func setCell() {
        
//        cityLabel.textColor = .black
        cityLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        cityLabel.backgroundColor = .red
                
//        temperatureLabel.backgroundColor = .blue
        temperatureLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        
//        weatherLabel.backgroundColor = .yellow
        weatherLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        
        
    }
}



//import UIKit
//
//class WeatherTableViewCell: UITableViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}
