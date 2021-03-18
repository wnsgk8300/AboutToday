//
//  ScheduleViewController.swift
//  Weather
//
//  Created by 신민희 on 2021/03/15.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
  
    
}

