//
//  LoadingHUD.swift
//  Weather
//
//  Created by 신민희 on 2021/03/17.
//

import Foundation
import UIKit

class LoadingHUD {
    private static let sharedInstance = LoadingHUD()
    
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    
    class func show() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        
        let popupView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        popupView.animationImages = LoadingHUD.getAnimationImageArray()
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
        animationArray.append(UIImage(named: "green-dress")!)
        animationArray.append(UIImage(named: "mittens")!)
        animationArray.append(UIImage(named: "closed-umbrella")!)
        animationArray.append(UIImage(named: "raincoat")!)
        animationArray.append(UIImage(named: "wedding-dress")!)
        animationArray.append(UIImage(named: "watches-front")!)
        animationArray.append(UIImage(named: "baseball-cap")!)
        animationArray.append(UIImage(named: "womens-shirt")!)
        animationArray.append(UIImage(named: "skirt")!)
        animationArray.append(UIImage(named: "jacket")!)
        return animationArray
    }
}
