//
//  WeatherViewController.swift
//  Weather
//
//  Created by 신민희 on 2021/03/15.
//

import UIKit

enum ListType {
    
    case cityWeather
}

class WeatherViewController: UIViewController {
    
    var selected: [String] = []
    let tableView = UITableView()
    let cityWeather = ["서울", "부산", "대구", "대전", "광주", "여수", "강릉", "인천"]
    var listType:ListType = .cityWeather
    let model = WeatherModel()
    var weather: Weather?
    var temp: String = ""
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setTableView()
    }


    func setTableView() {
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
        tableView.rowHeight = 120
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
   
    }
    
  
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeather.count
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else { fatalError() }
        //        cell.cityLabel.text = cityWeather[indexPath.row]
        switch cityWeather[indexPath.row] {
        case "서울":
            model.loadSeoulData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        case "대구":
            model.loadDaeguData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        case "대전":
            model.loadDaejeonData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        case "인천":
            model.loadIncheonData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        case "부산":
            model.loadBusanData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        case "여수":
            model.loadYeosuData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        case "강릉":
            model.loadGangneungData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        case "광주":
            model.loadGwangjuData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    cell.cityLabel.text = weather.cityName
                    cell.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    cell.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        cell.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        cell.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        cell.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        cell.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        cell.weatherImage.image = UIImage(named: "winter")
                    }
                    
                }
            })
        default:
            break
        }
        return cell
    }
    
}


extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let firstVC = ViewController()
        print(#function)
        switch #function {
        case "서울":
            model.loadSeoulData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    firstVC.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    firstVC.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        firstVC.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        firstVC.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        firstVC.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        firstVC.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        firstVC.weatherImage.image = UIImage(named: "winter")
                    }
                    firstVC.cityLabel.text = weather.cityName
                }
            })
        case "부산":
            model.loadBusanData(completion: {weather in
                self.weather = weather
                DispatchQueue.main.async {
                    firstVC.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                    self.temp = weather.today.first?.main ?? ""
                    firstVC.weatherLabel.text = weather.today.first?.main
                    if self.temp == "Clouds" {
                        firstVC.weatherImage.image = UIImage(named: "cloud")
                    } else if self.temp == "Clear" {
                        firstVC.weatherImage.image = UIImage(named: "clear")
                    } else if self.temp == "Haze" || self.temp == "Mist" {
                        firstVC.weatherImage.image = UIImage(named: "haze")
                    }else if self.temp == "Rain" {
                        firstVC.weatherImage.image = UIImage(named: "rain")
                    }else if self.temp == "Winter" {
                        firstVC.weatherImage.image = UIImage(named: "winter")
                    }
                    firstVC.cityLabel.text = weather.cityName
                }
            })

        default:
            print(123)
        }
    

        dismiss(animated: true, completion: nil)

    }
}
