
//
//  AddscheduleView.swift
//  SecondProject
//
//  Created by JEON JUNHA on 2021/03/14.
//

import UIKit

class AddScheduleViewController: UIViewController {
    let popUpView = UIView()
    let addButton = UIButton()
    let dismissButton = UIButton()
    let titleField = UITextField()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let timeField = UITextField()
    let placeLabel = UILabel()
    let placeField = UITextField()
    let memoField = UITextField()
    let myDatePicker: UIDatePicker = UIDatePicker()
    var selectedDate = ""
    var selectedTime = ""
    weak var delegate: AddscheduleViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        setUI()
        addTime()
    }
    func addTime() {
        myDatePicker.datePickerMode = .time
        myDatePicker.addTarget(self, action: #selector(selectTime(_:)), for: .valueChanged)
    }
    
    
    func setUI() {
        dateLabel.text = selectedDate
        dateLabel.textAlignment = .center
        dateLabel.font = dateLabel.font.withSize(28)
        titleField.font = titleField.font?.withSize(28)
        
        titleField.placeholder = "제목"
        timeLabel.text = "시간:"
        placeLabel.text = "위치:"
        placeField.placeholder = "위치"
        memoField.placeholder = "메모"
        
        // SetUp PopUpView
        popUpView.backgroundColor = UIColor.white
        
        [titleField, addButton ,dismissButton, dateLabel, timeLabel, myDatePicker, timeField, placeLabel, placeField, memoField].forEach {
            popUpView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //        [placeField, memoField ].forEach { (view) in
        //            view.borderStyle = .none
        //            let border = CALayer()
        //            border.frame = CGRect(x: 0, y: view.frame.size.height + 3, width: view.frame.width, height: 1)
        //            border.backgroundColor = UIColor.blue.cgColor
        //            view.layer.addSublayer((border))
        //            view.textAlignment = .left
        //            view.textColor = UIColor.black
        //            view.layer.cornerRadius = 5
        //        }
        
        view.addSubview(popUpView)
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.setTitle("확인", for: .normal)
        addButton.setTitleColor(UIColor.blue, for: .normal)
        addButton.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
        // SetUpDismiss Button
        dismissButton.setTitleColor(UIColor.blue, for: .normal)
        dismissButton.setTitle("취소", for: .normal)
        dismissButton.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
        
        let lead: CGFloat = 20
        let a: CGFloat = 20
        NSLayoutConstraint.activate([
            
            popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.widthAnchor.constraint(equalToConstant: 300),
            popUpView.heightAnchor.constraint(equalToConstant: 300),
            
            dateLabel.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: lead),
            dateLabel.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -lead),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            titleField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: a),
            titleField.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: a),
            timeLabel.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            
            myDatePicker.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            myDatePicker.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 8),
            
            placeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: a),
            placeLabel.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            
            placeField.topAnchor.constraint(equalTo: placeLabel.topAnchor),
            placeField.leadingAnchor.constraint(equalTo: placeLabel.trailingAnchor, constant: 16),
            placeField.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -lead),
            
            memoField.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: a),
            memoField.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            
            addButton.topAnchor.constraint(equalTo: memoField.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 80),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            dismissButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor, constant: -80),
            dismissButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    @objc func didTapDismissButton(_ sender: UIButton) {
        switch sender {
        case addButton:
            if CalendarData.shared.dateArr[selectedDate] == nil {
                CalendarData.shared.dateArr[selectedDate] = [myDatePicker.date: [titleField.text ?? "", placeField.text ?? "", memoField.text ?? ""]]
                delegate?.tableViewReload()
                dismiss(animated: true, completion: nil)
            } else {
                if CalendarData.shared.dateArr[selectedDate]![myDatePicker.date] == nil {
                CalendarData.shared.dateArr[selectedDate]![myDatePicker.date] =  [titleField.text ?? "", placeField.text ?? "", memoField.text ?? ""]
                    delegate?.tableViewReload()
                    dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: nil, message: "이미 일정이 존재합니다.", preferredStyle: .alert)
                let cancle = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alert.addAction(cancle)
                present(alert, animated: true)
            }
            }
            print(CalendarData.shared.dateArr)
        case dismissButton:
            delegate?.tableViewReload()
            dismiss(animated: true, completion: nil)
        default:
            fatalError()
        }
    }
    @objc func selectTime(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "hh:mm aa"
        selectedTime = dateformatter.string(from: myDatePicker.date)
    }
}

protocol AddscheduleViewDelegate: class {
    func tableViewReload()
}
