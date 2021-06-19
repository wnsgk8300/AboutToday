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
    var emptyImg : String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_5QaNylWhFr3MEqOmsiDH4vC7NKMxrpuQVQ&usqp=CAU"
    
    let calButton = UIButton(type: .system)
    let toDoTableView = UITableView()
    let dateFormatter = DateFormatter()
    var today = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWeather()
        setView()
        setDate()
        setTime()
        setAmPm()
        setDress()
        setNewsUI()
        setNewsTable()
        
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        toDoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "Cell")
        let now = Date()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        today = self.dateFormatter.string(from: now)
        setToDoUI()
    }
    
    //junha
    override func viewWillAppear(_ animated: Bool) {
        toDoTableView.reloadData()
    }
    func setToDoUI() {
        [calButton, toDoTableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        calButton.setTitle("일정 추가", for: .normal)
        calButton.addTarget(self, action: #selector(nextVC(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            calButton.topAnchor.constraint(equalTo: toDoTableView.bottomAnchor),
            calButton.centerXAnchor.constraint(equalTo: toDoTableView.centerXAnchor),

            toDoTableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor),
            toDoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toDoTableView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            toDoTableView.heightAnchor.constraint(equalToConstant: 160),

        ])
    }

    @objc
    func nextVC(_ sender: UIButton) {
        let nextVC = CalendarViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func setNewsUI() {
        view.backgroundColor = .white
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
            let url = URL(string: newsArray[index].urlToImage ?? emptyImg) ?? URL( string: emptyImg )
            do {
                let data = try Data(contentsOf: url! )
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

    
    func setWeather() {
        view.addSubview(weatherView)
        [weatherView, weatherImage, temperatureLabel, cityLabel, weatherLabel].forEach { (view) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: 160),
            
            weatherImage.leadingAnchor.constraint(equalTo: self.weatherView.leadingAnchor, constant: 10),
            weatherImage.topAnchor.constraint(equalTo: self.weatherView.topAnchor, constant: 20),
            weatherImage.heightAnchor.constraint(equalToConstant: 80),
            weatherImage.widthAnchor.constraint(equalToConstant: 80),
            
            cityLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor),
            cityLabel.topAnchor.constraint(equalTo: self.weatherView.topAnchor, constant: 20),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            cityLabel.widthAnchor.constraint(equalToConstant: 120),
            
            weatherLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            weatherLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            weatherLabel.heightAnchor.constraint(equalToConstant: 40),
            weatherLabel.widthAnchor.constraint(equalToConstant: 120),
            
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
        
        cityLabel.text = "도시"
        cityLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cityLabel.sizeToFit()
        cityLabel.textAlignment = .center
        
        weatherLabel.text = temp
        weatherLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        weatherLabel.textAlignment = .center

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
            dressButton.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        dressLabel.text = "오늘 날씨에 어울리는 \n 의상을 추천해 드립니다."
        dressLabel.numberOfLines = 0
        //        dressLabel.backgroundColor = .red
        dressLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        dressLabel.textAlignment = .right
        
        dressButton.setTitle("추천 의상 보러가기", for: .normal)
        dressButton.backgroundColor = .white
        dressButton.layer.cornerRadius = 3
        dressButton.setTitleColor(.black, for: .normal)
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
            dayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
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
        switch tableView {
        case toDoTableView:
            return CalendarData.shared.dateArr[today]?.count ?? 1
        default:
            return newsArray.count
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch tableView {
        case toDoTableView:
            if (editingStyle == .delete) {
                let time = CalendarData.shared.dateArr[today]?.keys.sorted(by: <)
                if let appointmentTime = time?[indexPath.item] {
                    CalendarData.shared.dateArr[today]?[appointmentTime] = nil
                    toDoTableView.reloadData()
                }
            }
        default:
            return
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case toDoTableView:
            guard let toDoCell = toDoTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                            as? ToDoTableViewCell else { fatalError() }
                    let time = CalendarData.shared.dateArr[today]?.keys.sorted(by: <)
                    guard let appointmentTime = time?[indexPath.item] else { return toDoCell }
                    dateFormatter.dateFormat = "aa hh:mm"
                    let stringTime = self.dateFormatter.string(from: appointmentTime)
                    toDoCell.timeLabel.text = stringTime
                    toDoCell.titleLabel.text = CalendarData.shared.dateArr[today]?[appointmentTime]?[0]
                    return toDoCell
        default:
            let customCell = (tableView.dequeueReusableCell(withIdentifier: "CustomNewsCell", for: indexPath) as! CustomNewsCell)
            
            customCell.titleLabel.text = newsArray[indexPath.item].title
            if !imageArray.isEmpty {
                customCell.mainImageView.image = imageArray[indexPath.item]
            }
            return customCell
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == toDoTableView {
        let time = CalendarData.shared.dateArr[today]?.keys.sorted(by: <)
        var place = ""
        var memo = ""
        if let appointmentTime = time?[indexPath.item] {
            place = CalendarData.shared.dateArr[today]?[appointmentTime]?[1] ?? "내용 없음"
            memo = CalendarData.shared.dateArr[today]?[appointmentTime]?[2] ?? "내용 없음"
        }
        let detailAlert = UIAlertController(title: "", message: "장소: \(place)\n메모: \(memo) ", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        detailAlert.addAction(cancelAction)
        present(detailAlert, animated: true, completion: nil)
        }
    }
}
