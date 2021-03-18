//
//  WeatherModel.swift
//  Weather
//
//  Created by 신민희 on 2021/03/15.
//

import Foundation

struct WeatherModel {
    let urlSeoulString = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=d3f9ecac3b883d295e3988bed318f823"
    let urlDaeguString = "https://api.openweathermap.org/data/2.5/weather?q=daegu&appid=d3f9ecac3b883d295e3988bed318f823"
    let urlDaejeonString = "https://api.openweathermap.org/data/2.5/weather?q=daejeon&appid=d3f9ecac3b883d295e3988bed318f823"
    let urlIncheonString = "https://api.openweathermap.org/data/2.5/weather?q=incheon&appid=d3f9ecac3b883d295e3988bed318f823"
    let urlBusanString = "https://api.openweathermap.org/data/2.5/weather?q=busan&appid=d3f9ecac3b883d295e3988bed318f823"
    let urlYeosuString = "https://api.openweathermap.org/data/2.5/weather?q=yeosu&appid=d3f9ecac3b883d295e3988bed318f823"
    let urlGangneungString = "https://api.openweathermap.org/data/2.5/weather?q=gangneung&appid=d3f9ecac3b883d295e3988bed318f823"
    let urlGwangjuString = "https://api.openweathermap.org/data/2.5/weather?q=gwangju&appid=d3f9ecac3b883d295e3988bed318f823"
    
    func loadSeoulData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlSeoulString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func loadDaeguData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlDaeguString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func loadDaejeonData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlDaejeonString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func loadIncheonData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlIncheonString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func loadBusanData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlBusanString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func loadYeosuData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlYeosuString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func loadGangneungData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlGangneungString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
    func loadGwangjuData(completion: @escaping (Weather) -> Void) {
        guard let url = URL(string: urlGwangjuString) else { fatalError() }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else{ return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(weather)
            } catch {
                print(error)
            }
        }).resume()
    }
    
}

