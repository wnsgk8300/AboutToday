//
//  CalendarData.swift
//  SecondProject
//
//  Created by JEON JUNHA on 2021/03/14.
//

import Foundation
struct CalendarData {
    static var shared = CalendarData()
    var dateArr: [String: [Date: [String]]] = [:]
    
    
    private init(){}
}

