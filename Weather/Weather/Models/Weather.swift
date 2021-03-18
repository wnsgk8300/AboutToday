//
//  Weather.swift
//  Weather
//
//  Created by 신민희 on 2021/03/15.
//

import Foundation


struct Weather: Decodable {
    
    let main: Main
    let today: [Today]
    let cityName: String
    
    struct Main: Decodable {
        let temp: Double
    }
    
    struct Today: Decodable {
        let main: String
    }
   
    enum CodingKeys: String, CodingKey {
        case main
        case today = "weather"
        case cityName = "name"
    }

}
