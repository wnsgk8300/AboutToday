//
//  LoadingWeather.swift
//  Weather
//
//  Created by 신민희 on 2021/03/17.
//

import Foundation
import UIKit

class LoadingWeather {
    private static let sharedInstance = LoadingWeather()
    
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    
    class func show() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        
        let popupView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        popupView.animationImages = LoadingWeather.getAnimationImageArray()
        popupView.animationDuration = 3
        popupView.animationRepeatCount = 0
        
        let loadingLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: 250, height: 100))
        loadingLabel.text = "Loading . . ."
        loadingLabel.textAlignment = .center
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        loadingLabel.textColor = .black
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            window.addSubview(loadingLabel)
            
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = .white
            
            popupView.center = window.center
            popupView.startAnimating()
            
            loadingLabel.layer.position = CGPoint(x: window.frame.midX, y: popupView.frame.maxY + 50)
            
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.loadingLabel?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.popupView = popupView
            sharedInstance.loadingLabel = loadingLabel
        }
    }
    
    class func hide() {
        if let popupView = sharedInstance.popupView,
            let loadingLabel = sharedInstance.loadingLabel,
        let backgroundView = sharedInstance.backgroundView {
            popupView.stopAnimating()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
            loadingLabel.removeFromSuperview()
        }
    }

    private class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "clear")!)
        animationArray.append(UIImage(named: "cloud")!)
        animationArray.append(UIImage(named: "haze")!)
        animationArray.append(UIImage(named: "rain")!)
        animationArray.append(UIImage(named: "umbrella")!)
        animationArray.append(UIImage(named: "winter")!)
        return animationArray
    }
}

