//
//  DressViewController.swift
//  Weather
//
//  Created by 신민희 on 2021/03/15.
//

import UIKit

class DressViewController: UIViewController {
    
    let dressImage = UIImageView()
    let weatherLabel = UILabel()
    let temperLabel = UILabel()
    let backButton = UIButton()
    let model = WeatherModel()
    var weather: Weather?
    var weatherTemp: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        setImage()
        setback()
        
    }
    func setback() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(back))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        view.addGestureRecognizer(tapGestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    @objc
    func back(_ sender:UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func setImage() {
        [dressImage, weatherLabel, temperLabel].forEach { (view) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            weatherLabel.heightAnchor.constraint(equalToConstant: 60),
            
            dressImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dressImage.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 80),
            dressImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dressImage.heightAnchor.constraint(equalToConstant: 300),
            
            temperLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            temperLabel.topAnchor.constraint(equalTo: dressImage.bottomAnchor, constant: 20),
            temperLabel.heightAnchor.constraint(equalToConstant: 30),
            temperLabel.widthAnchor.constraint(equalToConstant: 60),
            
            
            
            
        ])
        
        weatherLabel.text = "오늘 날씨에 어울리는 의상은 ????"
        weatherLabel.numberOfLines = 0
        weatherLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        weatherLabel.textAlignment = .center
        
        model.loadSeoulData(completion: {weather in
            self.weather = weather
            DispatchQueue.main.async {
                self.weatherTemp = Int(weather.main.temp - 273)
                if self.weatherTemp ?? 0 <= 5 {
                    self.dressImage.image = UIImage(named: "-5")
                } else if self.weatherTemp ?? 0 >= 6 && self.weatherTemp ?? 0 <= 9 {
                    self.dressImage.image = UIImage(named: "6-9")
                } else if self.weatherTemp ?? 0 >= 10 && self.weatherTemp ?? 0 <= 11 {
                    self.dressImage.image = UIImage(named: "10-11")
                } else if self.weatherTemp ?? 0 >= 12 && self.weatherTemp ?? 0 <= 16 {
                    self.dressImage.image = UIImage(named: "12-16")
                } else if self.weatherTemp ?? 0 >= 17 && self.weatherTemp ?? 0 <= 19 {
                    self.dressImage.image = UIImage(named: "17-19")
                } else if self.weatherTemp ?? 0 >= 20 && self.weatherTemp ?? 0 <= 22 {
                    self.dressImage.image = UIImage(named: "20-22")
                } else if self.weatherTemp ?? 0 >= 23 && self.weatherTemp ?? 0 <= 26 {
                    self.dressImage.image = UIImage(named: "23-26")
                } else if self.weatherTemp ?? 0 >= 27 {
                    self.dressImage.image = UIImage(named: "27-")}
                
                self.temperLabel.text = String(weather.main.temp - 273)
                
            }
        })
        
//        temperLabel.backgroundColor = .green
        temperLabel.alpha = 0
        temperLabel.text = "\(weatherTemp ?? 0)"
        
        dressImage.backgroundColor = .gray
        dressImage.layer.cornerRadius = 3

        
    
        
        
        
    }
    
}






