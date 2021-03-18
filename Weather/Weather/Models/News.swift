//
//  News.swift
//  Weather
//
//  Created by 신민희 on 2021/03/16.
//

import Foundation

struct News: Decodable{
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    
//    let aapl: AAPL
//
//    struct AAPL {
//        let price: String
//    }
}

struct NewsEnvelope: Decodable{
    let status: String
    let totalResults: Int
    let articles: [News]
}

