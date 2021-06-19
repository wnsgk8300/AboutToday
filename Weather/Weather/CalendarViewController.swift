
//
//  SecondViewController.swift
//  SecondProject
//
//  Created by JEON JUNHA on 2021/03/14.
//


import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    var calendar = FSCalendar()
    let dateFormatter = DateFormatter()
    let addButton = UIButton()
    var selectedDate = ""
    let xButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dateFormatter.dateFormat = "YYYY-MM-dd"
        selectedDate = self.dateFormatter.string(from: Date())
        calendar.allowsMultipleSelection = false
        calendar.delegate = self
        calendar.dataSource = self
        SetUI()
        SetCalendar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    func SetUI() {
        [xButton, calendar, addButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.addTarget(self, action: #selector(xTap(_:)), for: .touchUpInside)
        
        addButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addButton.addTarget(self, action: #selector(didTapPopUpButton(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            calendar.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -80),
            
            xButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            xButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            xButton.widthAnchor.constraint(equalToConstant: 36),
            xButton.heightAnchor.constraint(equalToConstant: 36),
            
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            addButton.widthAnchor.constraint(equalToConstant: 96),
            addButton.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
    func SetCalendar() {
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        calendar.scrollDirection = .vertical
    }
    @objc
    func xTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didTapPopUpButton(_ sender: UIButton) {
        let popUpViewController = AddScheduleViewController()
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.selectedDate = selectedDate
        popUpViewController.delegate = self
        present(popUpViewController, animated: true, completion: nil)
    }
}
extension CalendarViewController: FSCalendarDelegate {
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date))
        selectedDate = dateFormatter.string(from: date)
    }
}
extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        if CalendarData.shared.dateArr[dateFormatter.string(from: date)] != nil {
            return "\(CalendarData.shared.dateArr[dateFormatter.string(from: date)]?.count ?? 0)"
        } else {
            return nil
        }
        
    }
}


extension CalendarViewController: AddscheduleViewDelegate {
    func tableViewReload() {
        calendar.reloadData()
    }
}
