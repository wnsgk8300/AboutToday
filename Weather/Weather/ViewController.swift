//
//  ViewController.swift
//  Weather
//
//  Created by 신민희 on 2021/03/15.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let newsTableView = UITableView()
    var newsArray : [News] = []
    var imageArray: [UIImage] = []
    
    let weatherView = UIView()
    let temperatureLabel = UILabel()
    let cityLabel = UILabel()
    let weatherLabel = UILabel()
    let weatherImage = UIImageView()
    let model = WeatherModel()
    var weather: Weather?
    var temp: String = ""
    
    let dayView = UIView()
    let timeLabel = UILabel()
    let dateLabel = UILabel()
    let ampmLabel = UILabel()
    let scheduleButton = UIButton()
    
    let dressView = UIView()
    let dressLabel = UILabel()
    let dressButton = UIButton()
    
    let timeView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setTimeSchedule()
        setWeather()
        setView()
        setDate()
        setTime()
        setAmPm()
        setDress()
        setNewsUI()
        setNewsTable()
    }
    
    func setNewsUI() {
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        NetworkManager.shared.getNews{(news) in
            guard let news = news else {return}
            //            print(news[1].title)
            self.newsArray = news
            self.loadData()
            print(#function, self.newsArray.count)
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
            
        }
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsTableView.heightAnchor.constraint(equalToConstant: height - 480),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        newsTableView.rowHeight = 90
    }
    
    func setNewsTable(){
        newsTableView.register(CustomNewsCell.self, forCellReuseIdentifier: "CustomNewsCell")
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
    
    func loadData() {
        for index in newsArray.indices {
            let url = URL(string: newsArray[index].urlToImage ?? "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpicjumbo.com%2Ffree-photos%2Fggb%2F&psig=AOvVaw2cZ8wKxWennq431orLuDzd&ust=1615904727148000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKih6bnAsu8CFQAAAAAdAAAAABAD")
            do {
                guard let url = url else {
                    imageArray.append(UIImage())
                    
                    return }
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data) ?? UIImage()
                imageArray.append(image)
                print(#function, imageArray.count)
                //                newsTableView.reloadData()
            }
            catch {
                imageArray.append(UIImage())
                print("URL Error", error)
            }
        }
    }
    
    func setTimeSchedule() {
        view.addSubview(timeView)
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            timeView.topAnchor.constraint(equalTo: weatherView.bottomAnchor),
            timeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timeView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            timeView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        
    }
    
    func setWeather() {
        view.addSubview(weatherView)
        [weatherView, weatherImage, temperatureLabel, cityLabel, weatherLabel].forEach { (view) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: 160),
            
            weatherImage.leadingAnchor.constraint(equalTo: self.weatherView.leadingAnchor, constant: 20),
            weatherImage.topAnchor.constraint(equalTo: self.weatherView.topAnchor, constant: 20),
            weatherImage.heightAnchor.constraint(equalToConstant: 80),
            weatherImage.widthAnchor.constraint(equalToConstant: 80),
            
            cityLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 20),
            cityLabel.topAnchor.constraint(equalTo: self.weatherView.topAnchor, constant: 20),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            cityLabel.widthAnchor.constraint(equalToConstant: 60),
            
            weatherLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            weatherLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            weatherLabel.heightAnchor.constraint(equalToConstant: 40),
            weatherLabel.widthAnchor.constraint(equalToConstant: 60),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: weatherImage.centerXAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 30)
            
            
            
        ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(weatherTaped(_:)))
        self.weatherView.gestureRecognizers = [tapGestureRecognizer]
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        weatherView.backgroundColor = .systemIndigo
        weatherView.addGestureRecognizer(tapGestureRecognizer)
        weatherView.isUserInteractionEnabled = true
        
        //        self.temp = weather.today.first?.main
        //        if self.weatherTemp ?? 0 <= 5 {
        //            self.dressImage.image = UIImage(named: "-5")
        //        } else if
        
        model.loadSeoulData(completion: {weather in
            self.weather = weather
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(String(floor(weather.main.temp - 273)))°C"
                self.temp = weather.today.first?.main ?? ""
                self.weatherLabel.text = weather.today.first?.main
                if self.temp == "Clouds" {
                    self.weatherImage.image = UIImage(named: "cloud")
                } else if self.temp == "Clear" {
                    self.weatherImage.image = UIImage(named: "clear")
                } else if self.temp == "Haze" || self.temp == "Mist" {
                    self.weatherImage.image = UIImage(named: "haze")
                }else if self.temp == "Rain" {
                    self.weatherImage.image = UIImage(named: "rain")
                }else if self.temp == "Winter" {
                    self.weatherImage.image = UIImage(named: "winter")
                }
                self.cityLabel.text = weather.cityName
            }
        })
        
        //        weatherImage.backgroundColor = .red
        
        //        cityLabel.backgroundColor = .gray
        cityLabel.text = "도시"
        cityLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //        weatherLabel.backgroundColor = .green
        weatherLabel.text = temp
        weatherLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        //        temperatureLabel.backgroundColor = .white
        temperatureLabel.text = "온도"
        temperatureLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)

        
    }
    
    func setDress() {
        view.addSubview(dressView)
        dressView.backgroundColor = .systemIndigo
        [dressView, dressLabel, dressButton].forEach { (view) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dressView.topAnchor.constraint(equalTo: dayView.bottomAnchor),
            dressView.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            dressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dressView.heightAnchor.constraint(equalToConstant: 160),
            
            dressLabel.leadingAnchor.constraint(equalTo: self.dressView.leadingAnchor),
            dressLabel.trailingAnchor.constraint(equalTo: self.dressView.trailingAnchor),
            dressLabel.topAnchor.constraint(equalTo: self.dressView.topAnchor, constant: 10),
            dressLabel.heightAnchor.constraint(equalToConstant: 60),
            
            dressButton.centerXAnchor.constraint(equalTo: self.dressView.centerXAnchor),
            dressButton.topAnchor.constraint(equalTo: dressLabel.bottomAnchor, constant: 30),
            dressButton.heightAnchor.constraint(equalToConstant: 30),
            dressButton.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        dressLabel.text = "오늘 날씨에 어울리는 \n 의상을 추천해 드립니다."
        dressLabel.numberOfLines = 0
        //        dressLabel.backgroundColor = .red
        dressLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        dressLabel.textAlignment = .right
        
        dressButton.setTitle("추천 의상 보러가기", for: .normal)
        dressButton.backgroundColor = .gray
        dressButton.layer.cornerRadius = 3
        dressButton.setTitleColor(.white, for: .normal)
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped(_:)))
        self.dressButton.gestureRecognizers = [tap]
        dressButton.addTarget(self, action: #selector(dressButton(_:)), for: .touchUpInside)
        
    }
    
    func setView() {
        view.addSubview(dayView)
        dayView.backgroundColor = .systemBlue
        [dayView, timeLabel, dateLabel, ampmLabel, scheduleButton].forEach { (view) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            dayView.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            dayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dayView.heightAnchor.constraint(equalToConstant: 160),
            
            dateLabel.leadingAnchor.constraint(equalTo: self.dayView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: self.dayView.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: self.dayView.topAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 60),
            
            timeLabel.leadingAnchor.constraint(equalTo: self.dayView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: ampmLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 60),
            
            ampmLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10),
            ampmLabel.trailingAnchor.constraint(equalTo: self.dayView.trailingAnchor),
            ampmLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            ampmLabel.heightAnchor.constraint(equalToConstant: 60),
            
            scheduleButton.centerXAnchor.constraint(equalTo: self.dayView.centerXAnchor),
            scheduleButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            scheduleButton.heightAnchor.constraint(equalToConstant: 30),
            scheduleButton.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        //        scheduleButton.backgroundColor = .black
        scheduleButton.setTitle("오늘 일정 확인하기", for: .normal)
        scheduleButton.alpha = 0
        scheduleButton.layer.cornerRadius = 3
        scheduleButton.setTitleColor(.white, for: .normal)
        scheduleButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        
    }
    
    
    func setDate() {
        //        dateLabel.backgroundColor = .red
        dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        dateLabel.textAlignment = .right
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "us")
        dateformatter.dateFormat = "EEEE MM-dd \n yyyy"
        let date = dateformatter.string(from: Date())
        dateLabel.text = date
        dateLabel.numberOfLines = 0
    }
    
    func setTime() {
        //        timeLabel.backgroundColor = .green
        timeLabel.font = UIFont.boldSystemFont(ofSize: 50)
        timeLabel.textAlignment = .center
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "us")
        dateformatter.dateFormat = "HH:mm"
        let date = dateformatter.string(from: Date())
        timeLabel.text = date
        timeLabel.numberOfLines = 0
    }
    
    
    func setAmPm() {
        //        ampmLabel.backgroundColor = .blue
        ampmLabel.font = UIFont.boldSystemFont(ofSize: 30)
        ampmLabel.sizeToFit()
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "us")
        dateformatter.dateFormat = "a"
        let date = dateformatter.string(from: Date())
        ampmLabel.text = date
        ampmLabel.numberOfLines = 0
        
    }
    
    @objc
    func weatherTaped(_ sender: UITapGestureRecognizer) {
        LoadingWeather.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let nextVC = WeatherViewController()
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
            LoadingWeather.hide()
        }
    }
    
    @objc
    func taped(_ sender: UITapGestureRecognizer) {
       
        LoadingHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let nextVC = DressViewController()
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
            LoadingHUD.hide()
            
        }
    }
    
    @objc
    func handleButton(_ sender: UIButton){
        let nextVC = ScheduleViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
        
    }
    
    @objc
    func dressButton(_ sender: UIButton){
        let nextVC = DressViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    
    @objc
    func handleTap(sender: UITapGestureRecognizer) {
        let nextVC = WeatherViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
        
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = (tableView.dequeueReusableCell(withIdentifier: "CustomNewsCell", for: indexPath) as! CustomNewsCell)
        
        customCell.titleLabel.text = newsArray[indexPath.item].title
        if !imageArray.isEmpty {
            customCell.mainImageView.image = imageArray[indexPath.item]
        }
        return customCell
    }
    
    
}

extension ViewController : UITableViewDelegate{
    
}
